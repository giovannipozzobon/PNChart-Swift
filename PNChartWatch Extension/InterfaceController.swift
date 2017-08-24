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
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var datiScambiati : ExchageData = ExchageData()
    var chartTypes : Array<String> = [];

    var userDefault: UserDefaultUtility = UserDefaultUtility()    
    
    @IBOutlet var chartTable: WKInterfaceTable!
    
    //Indicatori di caricamento dei dati
    var graphLoaded : Bool = false;
    var topOrderLoaded : Bool = false;
    var topUserLoaded : Bool = false;

    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Activate the session on both sides to enable communication.
        if (WCSession.isSupported()) {
            let session = WCSession.default()
            session.delegate = self // conforms to WCSessionDelegate
            session.activate()
        }
    }
    
    override func willActivate()  {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        // ricarica i dati utente
        userDefault.readValueUser()
                
        
        //let querypointGraph : String = String("http://88.36.205.44:61862/QueryPoint/term.getOrdersAmount?qry=")
        //let querypointGraph : String = String("http://192.168.0.230:61862/QueryPoint/term.getOrdersAmount?qry=")
        let querypointGraph = userDefault.urlOrder
        
        print(querypointGraph)
        
        let parametersGraph: Parameters = [
            "startDate": "20170712",
            "endDate": "20170801"
            ]

        //let querypointTopOrder : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopOrder?qry=")
        //let querypointTopOrder : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopOrder?qry=")
        let querypointTopOrder = userDefault.urlCustomer
        
        print(querypointTopOrder)
        
        let parametersTopOrder: Parameters = [
            "Date": "20170504"
        ]
 
        //let querypointTopUser : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopUser?qry=")
        //let querypointTopUser : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopUser?qry=")
        let querypointTopUser = userDefault.urlSales
        
        print(querypointTopUser)
        
        let parametersTopUser: Parameters = [
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
        
        // carica i dati per i grafici
        Alamofire.request(querypointGraph, method: .post, parameters: parametersGraph, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
            
            
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrGraphRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrGraphRes: \(self.datiScambiati.arrGraphRes) \n")
                    }
                    
                    self.graphLoaded = true

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
                    
                    self.topOrderLoaded = true
                    
                }
                
        }
 
        
        /*
        // nuova chiamata a WebService usando l'oggetto webServiceCaller. Non funziona
        let webServiceCaller = WebServiceCaller()
        let webServiceInfo = WebServiceInfo()
        webServiceCaller.webServiceInfo = webServiceInfo
        webServiceCaller.callWebService(type: "term.getTopOrder", risultati: &self.datiScambiati.arrTopOrderRes)
         print("datiScambiati.arrTopOrderRes: \(self.datiScambiati.arrTopOrderRes) \n")
        */
        
        // carica i dati del top user
        Alamofire.request(querypointTopUser, method: .post, parameters: parametersTopUser, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrTopUserRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrTopUserRes: \(self.datiScambiati.arrTopUserRes) \n")
                    }
                    
                    self.topUserLoaded = true
                    
                }
                
        }
        
        //Carica la tabella con i vai tipi di grafico
        /* TODO: da differenziare quando i dati dei grafici, toporder e topusseer vengono caricati o meno*/
        
        self.chartTypes = ["Line Chart", "Bar Chart", "Pie Chart", "Circle Chart", "Radar Chart", "Top Order", "Top User", "Dett Order"]
        
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

    // =========================================================================
    // MARK: - WCSessionDelegate

        @available(iOS 9.3, watchOS 2.2, *)
        public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            
            
            print(#function)
            print("sessione : activationDidCompleteWith")

    }
    
    // Received message from iPhone
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        print(#function)
        
        print(message)
        
        userDefault.saveValueDictonary(dict : message)

        
        /*
        guard message["request"] as? String == "showAlert" else {return}
        
        
        let defaultAction = WKAlertAction(
            title: "OK",
            style: WKAlertActionStyle.default) { () -> Void in
        }
        
        lancia un alert per le prove di comunicazione
        let actions = [defaultAction]
        
        self.presentAlert(
            withTitle: "Message Received",
            message: "",
            preferredStyle: WKAlertControllerStyle.alert,
            actions: actions)
        */
    }
 

    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {

            //return self.chartTypes[rowIndex]
        
            datiScambiati.chartType         = self.chartTypes[rowIndex]
            datiScambiati.graphLoaded       = self.graphLoaded;
            datiScambiati.topOrderLoaded    = self.topOrderLoaded;
            datiScambiati.topUserLoaded     = self.topUserLoaded;

        
            return self.datiScambiati
    }

}
