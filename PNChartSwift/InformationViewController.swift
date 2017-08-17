//
//  InformationViewController.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 17/08/17.
//
//

import UIKit

class InformationViewController: TemplateViewController {
  
    @IBOutlet weak var lblInformation: UILabel!
    var testo : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // recupera le informazioni e prepara la label in base alla scelta fatta
        switch chartType {
            case "Top Order":
            
            testo = "Top Ordini:\n\n"
            
            for (_, dict) in self.exchangeData.arrTopOrderRes.enumerated() {
                
                let amount = dict["Amount"] as? String
                
                
                let contact = dict["Contact"] as? String
                
                testo = testo + contact! + " \n" + Utility.convertCurrency(valore: amount!) + "\n\n"
                
            }
            print ("TopOrder \(testo)")

        case "Top User" :
            
            testo = "Top Agenti:\n\n"
            for (_, dict) in self.exchangeData.arrTopUserRes.enumerated() {
                
                let amount = dict["Amount"] as? String
                
                let user = dict["User"] as? String
                
                testo = testo + user! + "\n" + Utility.convertCurrency(valore: amount!) + "\n\n"
                
            }
            
            print ("TopUser \(testo)")
        
        case "Dett Order" :
            
            testo = "Dettaglio Ordini:\n\n"
            for (_, dict) in self.exchangeData.arrGraphRes.enumerated() {
                
                let amount = dict["amount"] as? String
                
                let dateString = dict["date"] as? String
                
                testo = testo + "Data: " + Utility.convertDate(valore: dateString!) + "\n" + Utility.convertCurrency(valore: amount!) + "\n\n"
                
            }
            
            print ("Dettaglio Ordini: \(testo)")

        

            default:
            testo = " Nessuna informazione disponibile per l'opzione selezionata"
        }
        
        lblInformation.text = testo
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
