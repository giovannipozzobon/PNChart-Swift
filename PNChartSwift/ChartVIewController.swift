//
//  SecondViewController.swift
//  ManagementTool
//
//  Created by Giovanni Pozzobon on 07/04/17.
//  Copyright © 2017 Giovanni Pozzobon. All rights reserved.
//

import UIKit

class ChartViewController: TemplateViewController {

    
    @IBOutlet weak var lblCaricamento: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        if exchangeData.graphLoaded == true {
            
            
            //nascondi la label di caricamento
            lblCaricamento.isHidden = true

            
            
            // COMMON DATA
            var data01Array: [CGFloat] = []
            var xLabelArray: [String] = []
            var yLabelArray: [String] = []
            
            for (_, dict) in self.exchangeData.arrGraphRes.enumerated() {
                
                let number  = dict["amount"] as? String
                let n = CGFloat((number! as NSString).floatValue)
                yLabelArray.append(number!)
                data01Array.append(n)
                
                let dateString = dict["date"] as? String
                xLabelArray.append(Utility.convertDateToDayOnly(valore: dateString!))
                
            }

            
            
            // LINE CHART
            let lineChart = PNLineChart(frame: CGRect(x: 0.0, y: 135.0, width: 320.0, height: 250.0))
            lineChart.yLabelFormat = "%1.0f"
            lineChart.showLabel = true
            lineChart.backgroundColor = UIColor.clear
            lineChart.showCoordinateAxis = true
            lineChart.center = self.view.center

            lineChart.xLabelWidth = 10.0;
            lineChart.axisWidth = 1.0;
            
            
            lineChart.xLabels = xLabelArray as NSArray
            let dataArr = data01Array
            let data = PNLineChartData()
            data.color = PNGreen
            data.itemCount = dataArr.count
            data.inflexPointStyle = .None
            data.getData = ({
                (index: Int) -> PNLineChartDataItem in
                let yValue = CGFloat(dataArr[index])
                let item = PNLineChartDataItem(y: yValue)
                return item
            })
            
            lineChart.chartData = [data]
            lineChart.strokeChart()

            
            // BAT CHART
            let barChart = PNBarChart(frame: CGRect(x: 0.0, y: 135.0, width: 320.0, height: 200.0))
            barChart.backgroundColor = UIColor.clear

            barChart.showLabel = true
            barChart.animationType = .Waterfall
            barChart.labelMarginTop = 5.0
            barChart.xLabels = xLabelArray
            barChart.yValues = data01Array
            
            barChart.yChartLabelWidth = 25
            barChart.yLabels = yLabelArray
            barChart.strokeChart()
            barChart.center = self.view.center
            

            // PIE CHART
            var items : [PNPieChartDataItem] = []
            
            let ColorArray : [UIColor] = [PNLightGreen, PNFreshGreen, PNDeepGreen, PNDeepGrey, PNDarkBlue,PNLightBlue]
            
            for i in 0..<data01Array.count {
                
                let item : PNPieChartDataItem = PNPieChartDataItem(dateValue: data01Array[i], dateColor: ColorArray[i%6], description: xLabelArray[i])
                items.append(item)
                
            }
            
            let frame = CGRect(x: 0.0, y: 135.0, width: 320.0, height: 320.0)
            let pieChart = PNPieChart(frame: frame, items: items)
            
            pieChart.descriptionTextColor = UIColor.white
            pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 12.0)!
            pieChart.center = self.view.center
            
            
            
            // Visualizza il grafico appropriato
            switch chartType {
            case "Line Chart":
                self.view.addSubview(lineChart)
            case "Bar Chart" :
                self.view.addSubview(barChart)
            case "Pie Chart" :
                self.view.addSubview(pieChart)
            default:
                self.view.addSubview(lineChart)
            }
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


