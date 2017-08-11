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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // riempi l'array che poi saranno le righe della tabella
        nameCharts = ["Line Chart", "Bar Chart", "Pie Chart", "Circle Chart", "Radar Chart", "Top Order", "Top User", "Dett Order"]
        
        // anche se non usate per ora prepariamo la gestione di più ViewControll chiamati una per una ogni riga della tabella
        vc_StoryBoardID = ["Chart", "Chart", "Chart", "Chart", "Chart", "Chart", "Chart", "Chart"]

    
        let querypointGraph : String = String("http://88.36.205.44:61862/QueryPoint/term.getOrdersAmount?qry=")
        //let querypointGraph : String = String("http://192.168.0.230:61862/QueryPoint/term.getOrdersAmount?qry=")
        
        print(querypointGraph)
        
        let parametersGraph: Parameters = [
            "startDate": "20170712",
            "endDate": "20170801"
        ]
        
        let querypointTopOrder : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopOrder?qry=")
        //let querypointTopOrder : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopOrder?qry=")
        
        print(querypointTopOrder)
        
        let parametersTopOrder: Parameters = [
            "Date": "20170504"
        ]
        
        let querypointTopUser : String = String("http://88.36.205.44:61862/QueryPoint/term.getTopUser?qry=")
        //let querypointTopUser : String = String("http://192.168.0.230:61862/QueryPoint/term.getTopUser?qry=")
        
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
        
    
    
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return nameCharts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = nameCharts[indexPath.row]
        
        return cell!
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // dar usare in caso di più view
        let vc_Name = vc_StoryBoardID[indexPath.row]
        let viewController = (storyboard?.instantiateViewController(withIdentifier: vc_Name) as! ChartViewController)
        
        viewController.exchangeData = datiScambiati
        viewController.chartType = nameCharts[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)

        
    }
    
    /* Questa funzione non viene chiamata perchè viene chiamata quella della ViewTable
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var  indexPath : IndexPath = self.tableView.indexPathForSelectedRow!
        
        let destViewController = segue.destination as! ChartViewController
        
        
        destViewController.exchangeData = datiScambiati
        destViewController.chartType = nameCharts[indexPath.row]
        
        
        
    }
     */

 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
