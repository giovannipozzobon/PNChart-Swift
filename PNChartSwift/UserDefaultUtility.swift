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
    let appGroupID = "group.eu.aton.onSalesiOS"
    
    
    func readValueUser() {
        
        let defaults = UserDefaults(suiteName: appGroupID)!
        
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
        
        let defaults = UserDefaults(suiteName: appGroupID)!
        
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
    
    
    func returnDictonaryValue() -> [String :  Any] {
        var dict: [String: Any] = [:]
        dict.updateValue(url, forKey: "URL")
        dict.updateValue(port, forKey: "Port")
        dict.updateValue(userName, forKey: "UserName")
        dict.updateValue(userPassword, forKey: "UserPassword")
        dict.updateValue(queryPointOrder, forKey: "QueryPointOrder")
        dict.updateValue(queryPointCustomer, forKey: "QueryPointCustomer")
        dict.updateValue(queryPointSales, forKey: "QueryPointSales")
        dict.updateValue(urlServerGUI, forKey: "onSalesServerGUI")
        dict.updateValue(protocollo, forKey: "Protocollo")
        
        return dict
    }
    
    func saveValueDictonary(dict : [String :  Any]) {
        
        let defaults = UserDefaults(suiteName: appGroupID)!
        
        self.url = dict[dict.index(forKey: "URL")!].value as! String
        self.port = dict[dict.index(forKey: "Port")!].value as! String
        self.userName = dict[dict.index(forKey: "UserName")!].value as! String
        self.userPassword = dict[dict.index(forKey: "UserPassword")!].value as! String
        self.queryPointOrder = dict[dict.index(forKey: "QueryPointOrder")!].value as! String
        self.queryPointCustomer = dict[dict.index(forKey: "QueryPointCustomer")!].value as! String
        self.queryPointSales = dict[dict.index(forKey: "QueryPointSales")!].value as! String
        self.urlServerGUI = dict[dict.index(forKey: "onSalesServerGUI")!].value as! String
        self.protocollo = dict[dict.index(forKey: "Protocollo")!].value as! Int
        
        
        defaults.set(self.url, forKey: "URL")
        defaults.set(self.port, forKey: "Port")
        defaults.set(self.userName, forKey: "UserName")
        defaults.set(self.userPassword, forKey: "UserPassword")
        defaults.set(self.queryPointOrder, forKey: "QueryPointOrder")
        defaults.set(self.queryPointCustomer, forKey: "QueryPointCustomer")
        defaults.set(self.queryPointSales, forKey: "QueryPointSales")
        defaults.set(self.urlServerGUI, forKey: "onSalesServerGUI")
        defaults.set(self.protocollo, forKey: "Protocollo")
        
        // deriva i querypoint
        switch protocollo {
        case 0:
            protocolloStringa = "https://"
        default:
            protocolloStringa = "http://"
        }
        
        
        urlOrder = protocolloStringa + url + ":" + port + "/" + queryPointOrder
        urlCustomer = protocolloStringa + url + ":" + port + "/" + queryPointCustomer
        urlSales = protocolloStringa + url + ":" + port + "/" + queryPointSales
        
        
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
