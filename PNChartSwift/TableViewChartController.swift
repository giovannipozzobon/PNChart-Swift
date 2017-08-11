//
//  TableViewChart.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 11/08/17.
//
//

import Foundation
import UIKit


class tableViewChartController: UITableViewController {
    
    var nameCharts = [String]()
    var vc_StoryBoardID = [String]()
    
    override func viewDidLoad() {
        // riempi l'array che poi saranno le righe della tabella
        nameCharts = ["Line Chart", "Bar Chart", "Pie Chart", "Circle Chart", "Radar Chart", "Top Order", "Top User", "Dett Order"]
        
        // anche se non usate per ora prepariamo la gestione di più ViewControll chiamati una per una ogni riga della tabella
        vc_StoryBoardID = ["Chart", "Chart", "Chart", "Chart", "Chart", "Chart", "Chart", "Chart"]
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
        let viewController = storyboard?.instantiateViewController(withIdentifier: vc_Name)
        self.navigationController?.pushViewController(viewController!, animated: true)
        
        
    }

}
