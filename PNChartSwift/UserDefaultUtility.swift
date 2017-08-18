//
//  UserDefaultUtility.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 17/08/17.
//
//

import Foundation

class UserDefaultUtility: NSObject {
    
    var url : String = ""
    var port : String = ""
    var userName : String = ""
    var userPassword : String = ""
    var protocollo : Int = 1
    var protocolloStringa : String = "https://"
    var queryPointOrder : String = ""
    var queryPointCustomer : String = ""
    var queryPointSales : String = ""
    var urlServerGUI : String = String("")
    var urlOrder : String = ""
    var urlCustomer : String = ""
    var urlSales : String = ""
    
    
    
    func readValueUser() {
        
        let defaults = UserDefaults.standard
        
        if !(defaults.object(forKey: "URL") == nil) {self.url = defaults.string(forKey: "URL")!}
        if !(defaults.object(forKey: "Port") == nil) {self.port = defaults.string(forKey: "Port")!}
        if !(defaults.object(forKey: "UserName") == nil) {self.userName = defaults.string(forKey: "UserName")!}
        if !(defaults.object(forKey: "UserPassword") == nil) {self.userPassword = defaults.string(forKey: "UserPassword")!}
        if !(defaults.object(forKey: "QueryPointOrder") == nil) {self.queryPointOrder = defaults.string(forKey: "QueryPointOrder")!}
        if !(defaults.object(forKey: "QueryPointCustomer") == nil) {self.queryPointCustomer = defaults.string(forKey: "QueryPointCustomer")!}
        if !(defaults.object(forKey: "QueryPointSales") == nil) {self.queryPointSales = defaults.string(forKey: "QueryPointSales")!}
        if !(defaults.object(forKey: "onSalesServerGUI") == nil) {self.urlServerGUI = defaults.string(forKey: "onSalesServerGUI")!}
        if !(defaults.object(forKey: "Protocollo") == nil) {
            self.protocollo = defaults.integer(forKey: "Protocollo")
        }
        
        switch protocollo {
        case 0:
            protocolloStringa = "https://"
        default:
            protocolloStringa = "http://"
        }
        
        
        urlOrder = protocolloStringa + url + ":" + port + "/" + queryPointOrder
        urlCustomer = protocolloStringa + url + ":" + port + "/" + queryPointCustomer
        urlSales = protocolloStringa + url + ":" + port + "/" + queryPointSales
        
        
        // stampa le stringhe lette
        print(self.url)
        print(self.port)
        print(self.userName)
        print(self.userPassword)
        print(self.protocollo)
        print(self.protocolloStringa)
        print(self.queryPointOrder)
        print(self.queryPointCustomer)
        print(self.queryPointSales)
        print(self.urlServerGUI)
        print(self.urlOrder)
        print(self.urlCustomer)
        print(self.urlSales)

    
        
    }

    func saveValueUser() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(self.url, forKey: "URL")
        defaults.set(self.port, forKey: "Port")
        defaults.set(self.userName, forKey: "UserName")
        defaults.set(self.userPassword, forKey: "UserPassword")
        defaults.set(self.queryPointOrder, forKey: "QueryPointOrder")
        defaults.set(self.queryPointCustomer, forKey: "QueryPointCustomer")
        defaults.set(self.queryPointSales, forKey: "QueryPointSales")
        defaults.set(self.urlServerGUI, forKey: "onSalesServerGUI")
        defaults.set(self.protocollo, forKey: "Protocollo")
        
        
        // stampa le stringhe salvate
        print(self.url)
        print(self.port)
        print(self.userName)
        print(self.userPassword)
        print(self.protocollo)
        print(self.queryPointOrder)
        print(self.queryPointCustomer)
        print(self.queryPointSales)
        print(self.urlSales)
        print(self.urlServerGUI)
        
    }

    
}
