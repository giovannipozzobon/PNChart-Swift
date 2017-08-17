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
    var protocollo = 1
    var protocolloStringa : String = "https://"
    
    func readValueUser() {
        
        let defaults = UserDefaults.standard
        
        if !(defaults.object(forKey: "URL") == nil) {self.url = defaults.string(forKey: "URL")!}
        if !(defaults.object(forKey: "Port") == nil) {self.port = defaults.string(forKey: "Port")!}
        if !(defaults.object(forKey: "UserName") == nil) {self.userName = defaults.string(forKey: "UserName")!}
        if !(defaults.object(forKey: "UserPassword") == nil) {self.userPassword = defaults.string(forKey: "UserPassword")!}
        if !(defaults.object(forKey: "Protocollo") == nil) {
            self.protocollo = defaults.integer(forKey: "Protocollo")
        }
        
        switch protocollo {
        case 0:
            protocolloStringa = "https://"
        default:
            protocolloStringa = "http://"
        }
        
        // stampa le stringhe lette
        print(self.url)
        print(self.port)
        print(self.userName)
        print(self.userPassword)
        print(self.protocollo)
        print(self.protocolloStringa)
        
    }

    func saveValueUser() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(self.url, forKey: "URL")
        defaults.set(self.port, forKey: "Port")
        defaults.set(self.userName, forKey: "UserName")
        defaults.set(self.userPassword, forKey: "UserPassword")
        defaults.set(self.protocollo, forKey: "Protocollo")
        
        // stampa le stringhe salvate
        print(self.url)
        print(self.port)
        print(self.userName)
        print(self.userPassword)
        print(self.protocollo)
        
    }

    
}
