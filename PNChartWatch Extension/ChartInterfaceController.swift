//
//  ChartInterfaceController.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 28/04/17.
//
//

import WatchKit
import Foundation


class ChartInterfaceController: WKInterfaceController {
    
    @IBOutlet var chartImage: WKInterfaceImage!
    
    @IBOutlet var labelInfoOrder: WKInterfaceLabel!
    
    var chartType : String = ""
    var arrayValori = [[String:AnyObject]]()
    var arrayOrderTop = [[String:AnyObject]]()
    var arrayUserTop = [[String:AnyObject]]()
    
    var ColorArray : [UIColor] = []

    //Colori definiti con edefine in Object-C ma che non vengono visti da Swift
    let NKGreen = UIColor(colorLiteralRed: 77.0 / 255.0, green: 186.0 / 255.0, blue: 122.0 / 255.0, alpha: 1.0)
    let NKLightGrey = UIColor (colorLiteralRed:225.0 / 255.0, green:225.0 / 255.0, blue:225.0 / 255.0, alpha:1.0)
    let NKTwitterColor = UIColor (colorLiteralRed:0.0 / 255.0, green:171.0 / 255.0, blue:243.0 / 255.0, alpha:1.0)
    let NKRed = UIColor (colorLiteralRed:245.0 / 255.0, green:94.0 / 255.0, blue:78.0 / 255.0, alpha:1.0)
    let NKLightGreen = UIColor(colorLiteralRed:77.0 / 255.0, green:216.0 / 255.0, blue:122.0 / 255.0, alpha:1.0)
    let NKFreshGreen = UIColor(colorLiteralRed:77.0 / 255.0, green:196.0 / 255.0, blue:122.0 / 255.0, alpha:1.0)
    let NKDeepGreen = UIColor(colorLiteralRed:77.0 / 255.0, green:176.0 / 255.0, blue:122.0 / 255.0, alpha:1.0)

    let shadowColor = UIColor(colorLiteralRed:225.0 / 255.0, green:225.0 / 255.0, blue:225.0 / 255.0, alpha:0.5)
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        //self.chartType = context as! String;
       
        self.chartType = (context as! ExchageData).chartType
        self.arrayValori = (context as! ExchageData).arrGraphRes
        self.arrayOrderTop = (context as! ExchageData).arrTopOrderRes
        self.arrayUserTop = (context as! ExchageData).arrTopUserRes
        
        print(self.chartType)
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()   


        ColorArray = [NKGreen, NKLightGrey, NKTwitterColor, NKRed, NKLightGreen, NKFreshGreen, NKDeepGreen]

        let image : UIImage
        let frame : CGRect = CGRect(x: 0.0, y: 0.0, width: self.contentFrame.size.width, height: self.contentFrame.size.height)
        
        if (self.chartType == "Line Chart")
        {
            let chart : NKLineChart = NKLineChart(frame: frame)
            chart.yLabelFormat = "%1.1f"
            //chart.xLabels=["SEP 1","SEP 2","SEP 3","SEP 4","SEP 5","SEP 6","SEP 7"]
            
            chart.isShowCoordinateAxis = true
            
            //Use yFixedValueMax and yFixedValueMin to Fix the Max and Min Y Value
            //Only if you needed
            chart.yFixedValueMax = 1000.0;
            chart.yFixedValueMin = 0.0;
            
           /* chart.yLabels = [
                "0",
                "50",
                "100",
                "150",
                "200",
                "250",
                "300",
                ]
*/
        
            
            chart.yLabelFont = UIFont.systemFont(ofSize: 6.0)
            chart.xLabelFont = UIFont.systemFont(ofSize: 6.0)
            chart.xLabelWidth = 10.0;
            chart.yLabelColor = NKGreen
            chart.xLabelColor = NKGreen
            
            chart.axisColor = NKLightGrey;
            chart.axisWidth = 1.0;
            
            chart.xUnit = "Day";
            chart.yUnit = "Eur";
            
            // Line Chart #1
            //let data01Array: [CGFloat] = [60.1, 160.1, 126.4, 0.0, 186.2, 127.2, 176.2]
            
            var data01Array: [CGFloat] = []
            chart.xLabels = []
            chart.yLabels = []
            
            for (_, dict) in self.arrayValori.enumerated() {
                
                let number  = dict["amount"] as? String
              //  let n = CGFloat(NumberFormatter().number(from: number)!)
                let n = CGFloat((number! as NSString).floatValue)
                data01Array.append(n)
                chart.yLabels.append(number ??  "")
                
                let dateString = dict["date"] as? String
                chart.xLabels.append(dateString ??  "")

            }

            chart.yFixedValueMax = data01Array.max()!
            chart.yFixedValueMin = data01Array.min()!
            
            let data01 = NKLineChartData()
            data01.color =  NKGreen
            data01.alpha = 0.9;
            data01.itemCount = UInt(data01Array.count)
            data01.inflexionPointStyle = NKLineChartPointStyle.triangle
            data01.getData = {(index : UInt) -> NKLineChartDataItem in
                let yValue : CGFloat = CGFloat(data01Array[Int(index)] as NSNumber)
                return NKLineChartDataItem.init(y: yValue)
            }

            // Line Chart #2
/*            let data02Array : [CGFloat] = [0.0, 180.1, 26.4, 202.2, 126.2, 167.2, 276.2]
            let data02 : NKLineChartData = NKLineChartData()
            data02.color = NKTwitterColor;
            data02.alpha = 0.5
            data02.itemCount = UInt(data02Array.count)
            data02.inflexionPointStyle = NKLineChartPointStyle.circle;
            data02.getData = {(index : UInt) -> NKLineChartDataItem in
                let yValue : CGFloat = CGFloat(data02Array[Int(index)] as NSNumber)
                return NKLineChartDataItem.init(y: yValue)
            }

 
            chart.chartData = [data01,data02]
*/
            chart.chartData = [data01]
            
            image = chart.drawImage()
            
            
          }  else if (self.chartType == "Bar Chart")
        {
            let chart : NKBarChart = NKBarChart (frame: frame)
            
            chart.yLabelFormatter = { (yValue : CGFloat) -> String in
                let yValueParsed = CGFloat(yValue);
                let labelText : String = String(format:"%0.f",yValueParsed)
                return labelText
            }

            
            chart.labelMarginTop = 5.0
            chart.showChartBorder = true
           
            
            /*
            chart.xLabels = ["2","3","4","5","2","3","4","5"]
            //       self.barChart.yLabels = @[@-10,@0,@10];
            chart.yValues = [10.82,1.88,6.96,33.93,10.82,1.88,6.96,33.93]
            chart.strokeColors = [NKGreen,NKGreen,NKRed,NKGreen,NKGreen,NKGreen,NKRed,NKGreen]
            */

            chart.xLabels = []
            chart.yValues = []
            chart.strokeColors = []
            
            for (index, dict) in self.arrayValori.enumerated() {
                
                let number  = dict["amount"] as? String
                //  let n = CGFloat(NumberFormatter().number(from: number)!)
                let n = CGFloat((number! as NSString).floatValue)
                
                let dateString = dict["date"] as? String
                
                chart.xLabels.append(dateString!)
                chart.yValues.append(n)
                
                chart.strokeColors.append(self.ColorArray[index%6])
                
            }

            
            
            image = chart.drawImage()
    
    } else if (self.chartType == "Pie Chart")
   
        {
            /*
            let items : [NKPieChartDataItem] = [
            NKPieChartDataItem(value: 10, color: NKLightGreen),
            NKPieChartDataItem (value: 20, color: NKFreshGreen, description: "WWDC"),
            NKPieChartDataItem (value: 40, color: NKDeepGreen, description: "GOOG I/O")
            ]
            */

            var items : [NKPieChartDataItem] = []
            
            for (index, dict) in self.arrayValori.enumerated() {
                
                let number  = dict["amount"] as? String
                //  let n = CGFloat(NumberFormatter().number(from: number)!)
                let n = CGFloat((number! as NSString).floatValue)
                
                let dateString = dict["date"] as? String
                
                let item : NKPieChartDataItem = NKPieChartDataItem(value: n, color: self.ColorArray[index%6], description: dateString)
                items.append(item)
                
                
            }
            
            
    
            let chart : NKPieChart = NKPieChart(frame: frame, items: items)
            chart.descriptionTextColor = UIColor.white
            chart.descriptionTextFont  = UIFont.systemFont(ofSize:12.0)
            chart.showAbsoluteValues = false
            chart.showOnlyValues = false
            
            image = chart.drawImage()
            
        } else if (self.chartType == "Circle Chart")
        {
            
           
            let chart : NKCircleChart = NKCircleChart (frame:frame, total:100, current:60, clockwise:true, shadow:true, shadowColor:shadowColor, displayCountingLabel:true, overrideLineWidth:5)
            chart.strokeColor = NKGreen
            chart.strokeColorGradientStart = NKLightGreen
            
            
            image = chart.drawImage()
            
        } else if (self.chartType == "Radar Chart")
        {
          /*  let items : [NKRadarChartDataItem] = [
            NKRadarChartDataItem(value:3, description:"Art"),
            NKRadarChartDataItem(value:2, description:"Math"),
            NKRadarChartDataItem(value:8, description:"Sports"),
            NKRadarChartDataItem(value:5, description:"Liter"),
            NKRadarChartDataItem(value:4, description:"Other")
            ]
            */
            
            
            var items : [NKRadarChartDataItem] = []
            
            for (_, dict) in self.arrayValori.enumerated() {
                
                let number  = dict["amount"] as? String
                //  let n = CGFloat(NumberFormatter().number(from: number)!)
                let n = CGFloat((number! as NSString).floatValue)
                
                let dateString = dict["date"] as? String
                
                let item : NKRadarChartDataItem = NKRadarChartDataItem(value: n, description: dateString)
                items.append(item)
                
                
            }
            
             let chart : NKRadarChart = NKRadarChart(frame:frame, items:items, valueDivider:1)
            
            image = chart.drawImage()
            
        } else if (self.chartType == "TopOrder") {
            
            var testo : String = ""
            
            for (_, dict) in self.arrayOrderTop.enumerated() {
                
                let number  = dict["Order"] as? String
              
                let amount = dict["Amount"] as? String
                
                let user = dict["User"] as? String
                
                let contact = dict["Contact"] as? String
 
                testo = testo + number! + amount! + user! + contact!
            
            }
            print ("TopOrder \(testo)")
            self.labelInfoOrder.setText(testo)
            image = UIImage()
            
        
        } else if (self.chartType == "TopUser") {
    
            var testo : String = ""
    
            for (_, dict) in self.arrayUserTop.enumerated() {
    
            let amount = dict["Amount"] as? String
    
            let user = dict["User"] as? String
    
            testo = testo + user! + amount! + user!
    
        }
        print ("TopUser \(testo)")
        self.labelInfoOrder.setText(testo)
        image = UIImage()
        
    
    }
    
        else
        {
            print("don't support now.")
            image = UIImage()
        }
    
        self.chartImage.setImage(image)
    
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
