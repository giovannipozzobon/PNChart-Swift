//
//  TableViewChart.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 11/08/17.
//
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON


class tableViewChartController: UITableViewController {
    
    var nameCharts = [String]()
    var vc_StoryBoardID = [String]()

    var datiScambiati : ExchageData = ExchageData()
    var chartTypes : Array<String> = [];
    
    //Indicatori di caricamento dei dati
    var graphLoaded : Bool = false;
    var topOrderLoaded : Bool = false;
    var topUserLoaded : Bool = false;

    var userDefault: UserDefaultUtility = UserDefaultUtility()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // riempi l'array che poi saranno le righe della tabella
        nameCharts = ["Line Chart", "Bar Chart", "Pie Chart", "Top Order", "Top User", "Dett Order"]
        
        // anche se non usate per ora prepariamo la gestione di più ViewControll chiamati una per una ogni riga della tabella
        vc_StoryBoardID = ["Chart", "Chart", "Chart", "Information", "Information", "Information"]

        // inizializza le variabili flag che indicano il caricamenteo dei dati
        datiScambiati.graphLoaded = false
        datiScambiati.topUserLoaded = false
        datiScambiati.topOrderLoaded = false
    
        // carica gli URL utente
        userDefault.readValueUser()
        
        // carica i dati per i grafici
        caricaJSONOrdini()
        
        
        // carica i dati per il TopOrders
        caricaJSONTopOrders()
 
        // carica i dati per i TopUsers
        caricaJSONTopUsers()
        
        /* codice per uso di test per verificare le risposte dei vari WebServices
         Alamofire.request(querypoint,  method: .post, parameters: parameters, encoding: JSONEncoding.default).response { response in
         //Alamofire.request("http://188.125.99.46:61862/QueryPoint/term.getOrdersAmount?qry={"startDate": "20100501","endDate": "20180505"}").response { response in
         print("Request: \(String(describing: response.request))")
         print("Response: \(String(describing: response.response))")
         print("Error: \(String(describing: response.error))")
         
         if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
         print("Data: \(utf8Text)")
         }*/
  
    
    
    }

    // MARK: -
    // MARK: caricamento JSON
    
    func caricaJSONOrdini() -> Void {

        //let querypointGraph : String = String("http://88.36.205.44:61862/QueryPoint/term.getOrdersAmount?qry=")
        //let querypointGraph : String = String("http://192.168.0.230:61862/QueryPoint/term.getOrdersAmount?qry=")
        
        let querypointGraph = userDefault.urlOrder
        
        print(querypointGraph)
        
        let parametersGraph: Parameters = [
            "startDate": "20170712",
            "endDate": "20170801"
        ]
        
        Alamofire.request(querypointGraph, method: .post, parameters: parametersGraph, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrGraphRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrGraphRes: \(self.datiScambiati.arrGraphRes) \n")
                    }
                    
                    self.datiScambiati.graphLoaded = true
                    
                }
                
        }
    }
    
    func caricaJSONTopOrders() -> Void {

        //let querypointTopOrder : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopOrder?qry=")
        //let querypointTopOrder : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopOrder?qry=")
        
        let querypointTopOrder = userDefault.urlCustomer
        print(querypointTopOrder)
        
        let parametersTopOrder: Parameters = [
            "Date": "20170504"
        ]
        
        // carica i dati del top order
        Alamofire.request(querypointTopOrder, method: .post, parameters: parametersTopOrder, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrTopOrderRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrTopOrderRes: \(self.datiScambiati.arrTopOrderRes)")
                    }
                    
                    self.datiScambiati.topOrderLoaded = true
                    
                }
                
        }

        
    }

    func caricaJSONTopUsers() -> Void {
        //let querypointTopUser : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopUser?qry=")
        //let querypointTopUser : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopUser?qry=")
        
        let querypointTopUser = userDefault.urlSales
        
        print(querypointTopUser)
        
        let parametersTopUser: Parameters = [
            "startDate": "20100501",
            "endDate": "20180505"
        ]
        
        // carica i dati del top user
        Alamofire.request(querypointTopUser, method: .post, parameters: parametersTopUser, encoding: JSONEncoding.default).responseJSON
            { (responseData) -> Void in
                
                
                if((responseData.result.value) != nil) {
                    let swiftyJsonVar = JSON(responseData.result.value!)
                    
                    if let resData = swiftyJsonVar["results"].arrayObject {
                        self.datiScambiati.arrTopUserRes = resData as! [[String:AnyObject]]
                        print("datiScambiati.arrTopUserRes: \(self.datiScambiati.arrTopUserRes) \n")
                    }
                    
                    self.datiScambiati.topUserLoaded = true
                    
                }
                
        }
        
    }
    
    // MARK: -
    // MARK: Lifecycle Tabella
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameCharts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = nameCharts[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc_Name = vc_StoryBoardID[indexPath.row]
        let viewController = (storyboard?.instantiateViewController(withIdentifier: vc_Name) as! TemplateViewController)
        
        viewController.exchangeData = datiScambiati
        viewController.chartType = nameCharts[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)

        
    }
    
    /* Questa funzione non viene chiamata perchè viene usata quella della ViewTable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var  indexPath : IndexPath = self.tableView.indexPathForSelectedRow!
        
        let destViewController = segue.destination as! ChartViewController
        
        
        destViewController.exchangeData = datiScambiati
        destViewController.chartType = nameCharts[indexPath.row]
        
        
        
    } */
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
