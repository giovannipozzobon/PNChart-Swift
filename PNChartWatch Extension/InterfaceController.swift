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
        
        var graphLoaded : Bool = false;
        var topOrderLoaded : Bool = false;
        var topUserLoaded : Bool = false;

        
        let querypointGraph : String = String("http://88.36.205.44:61862/QueryPoint/term.getOrdersAmount?qry=")

        print(querypointGraph)
        
        let parametersGraph: Parameters = [
            "startDate": "20170712",
            "endDate": "20170801"
            ]

        let querypointTopOrder : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopOrder?qry=")
        
        print(querypointTopOrder)
        
        let parametersTopOrder: Parameters = [
            "Date": "20170712"
        ]
 
        let querypointTopUser : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopUser?qry=")
        
        print(querypointTopUser)
        
        let parametersTopUser: Parameters = [
            "startDate": "20170712",
            "endDate": "20170801"
        ]
        
        
    /*    Alamofire.request(querypoint,  method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
        //Alamofire.request("http://188.125.99.46:61862/QueryPoint/term.getOrdersAmount?qry={"startDate": "20100501","endDate": "20180505"}").response { response in
        print("Request: \(String(describing: response.request))")
        print("Response: \(String(describing: response.response))")
        print("Error: \(String(describing: response.error))")
        
        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            print("Data: \(utf8Text)")
        }*/
        
        // carica i dati per i grafici
        Alamofire.request(querypointGraph, method: .post, parameters: parametersGraph, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
            
            
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrGraphRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrGraphRes: \(self.datiScambiati.arrGraphRes)")
                    }
                    
                    graphLoaded = true

                }
                    
        }
        
        // carica i dati del top order
        Alamofire.request(querypointTopOrder, method: .post, parameters: parametersTopOrder, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrTopOrderRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrTopOrderRes: \(self.datiScambiati.arrTopOrderRes)")
                    }
                    
                    topOrderLoaded = true
                    
                }
                
        }

        
        // carica i dati del top user
        Alamofire.request(querypointTopUser, method: .post, parameters: parametersTopUser, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrTopUserRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrTopUserRes: \(self.datiScambiati.arrTopUserRes)")
                    }
                    
                    topUserLoaded = true
                    
                }
                
        }
        
        //Carica la tabella con i vai tipi di grafico
        /* TODO: da differenziare quando i dati dei grafici, toporder e topusseer vengono caricati o meno*/
        
        self.chartTypes = ["Line Chart", "Bar Chart", "Pie Chart", "Circle Chart", "Radar Chart", "TopOrder", "TopUser"]
        
        self.chartTable.setNumberOfRows(self.chartTypes.count, withRowType: "ChartTableRowController")
        
        
        for (index, labelText) in self.chartTypes.enumerated() {
            let row = self.chartTable.rowController(at: index)
                as! ChartTableRowController
            row.charType.setText(labelText)

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
