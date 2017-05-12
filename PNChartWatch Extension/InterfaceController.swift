//
//  InterfaceController.swift
//  PNChartWatch Extension
//
//  Created by Giovanni Pozzobon on 28/04/17.
//
//

import WatchKit
import Foundation
import Alamofire
import SwiftyJSON


class InterfaceController: WKInterfaceController {
    
    var datiScambiati : ExchageData = ExchageData()
    var chartTypes : Array<String> = [];
    
    @IBOutlet var chartTable: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate()  {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
  
        let querypoint : String = String("http://188.125.99.46:61862/QueryPoint/term.getOrdersAmount?qry=")

        print(querypoint)
        
        let parameters: Parameters = [
            "startDate": "20100501",
            "endDate": "20180505"
            ]

        
    /*    Alamofire.request(querypoint,  method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
        //Alamofire.request("http://188.125.99.46:61862/QueryPoint/term.getOrdersAmount?qry={"startDate": "20100501","endDate": "20180505"}").response { response in
        print("Request: \(String(describing: response.request))")
        print("Response: \(String(describing: response.response))")
        print("Error: \(String(describing: response.error))")
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)")
        }*/
        
        
        Alamofire.request(querypoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
            
            if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrRes = resData as! [[String:AnyObject]]
                    }

  
                /*
                    self.chartTable.setNumberOfRows(self.datiScambiati.arrRes.count, withRowType: "ChartTableRowController")

                    for (index, dict) in self.datiScambiati.arrRes.enumerated() {
                        let row = self.chartTable.rowController(at: index)
                            as! ChartTableRowController
                        let testo = dict["amount"] as? String // dict["email"] as? String
                        row.charType.setText(testo)
                 }
   */
     
                
                //Carica la tabella con i vai tipi di grafico
                
                self.chartTypes = ["Line Chart", "Bar Chart", "Pie Chart", "Circle Chart", "Radar Chart"]
                
                self.chartTable.setNumberOfRows(self.chartTypes.count, withRowType: "ChartTableRowController")
                
                
                for (index, labelText) in self.chartTypes.enumerated() {
                    let row = self.chartTable.rowController(at: index)
                        as! ChartTableRowController
                    row.charType.setText(labelText)
                    
                }
    
                
                    
                }
        }
 
    }
    
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {

            //return self.chartTypes[rowIndex]
        
            datiScambiati.chartType = self.chartTypes[rowIndex]
            return self.datiScambiati
    }

}
