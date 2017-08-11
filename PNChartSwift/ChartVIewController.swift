//
//  SecondViewController.swift
//  ManagementTool
//
//  Created by Giovanni Pozzobon on 07/04/17.
//  Copyright © 2017 Giovanni Pozzobon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChartViewController: UIViewController {

    
    var chartType : String = ""
    var exchangeData : ExchageData = ExchageData()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let item1 = PNPieChartDataItem(dateValue: 20, dateColor:  PNLightGreen, description: "Build")
        let item2 = PNPieChartDataItem(dateValue: 20, dateColor: PNFreshGreen, description: "I/O")
        let item3 = PNPieChartDataItem(dateValue: 45, dateColor: PNDeepGreen, description: "WWDC")
        
        let frame = CGRect(x: 40.0, y: 155.0, width: 240.0, height: 240.0)
        let items: [PNPieChartDataItem] = [item1, item2, item3]
        let pieChart = PNPieChart(frame: frame, items: items)
        pieChart.descriptionTextColor = UIColor.white
        pieChart.descriptionTextFont = UIFont(name: "Avenir-Medium", size: 14.0)!
        pieChart.center = self.view.center
        
   
        
        
        // old but good
        
        let lineChart = PNLineChart(frame: CGRect(x: 0.0, y: 135.0, width: 320.0, height: 250.0))
    
        
    
        lineChart.yLabelFormat = "%1.0f"
        lineChart.showLabel = true
        lineChart.backgroundColor = UIColor.clear
        lineChart.showCoordinateAxis = true
        lineChart.center = self.view.center

        lineChart.xLabelWidth = 10.0;
        lineChart.axisWidth = 1.0;
    
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
  
        let barChart = PNBarChart(frame: CGRect(x: 0.0, y: 135.0, width: 320.0, height: 200.0))
        barChart.backgroundColor = UIColor.clear
        barChart.animationType = .Waterfall
        barChart.labelMarginTop = 5.0
        barChart.xLabels = xLabelArray
        barChart.yValues = data01Array
        
        barChart.yChartLabelWidth = 25
        barChart.yLabels = yLabelArray
        barChart.strokeChart()
        barChart.center = self.view.center
        
        
        
        
        // Change the chart you want to present here
        self.view.addSubview(barChart)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


