//
//  Utility.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 09/08/17.
//
//

import Foundation

class Utility : NSObject {

    static func convertCurrency (valore: String) -> String {
        
        if valore.isEmpty { return("0") }
        
        var valore2 :String
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        valore2 = valore
        if (valore2.isEmpty) {valore2="0"}
        let cifra : NSNumber = NSNumber(value: Double(valore2)!)
        return formatter.string(from: cifra as NSNumber)!


    }
    
    static func convertDate (valore: String) -> String {
        
        if (valore.isEmpty) || (valore.characters.count < 8) { return("") }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        
        let dateObj = dateFormatter.date(from: valore)
        
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: dateObj!)
    }
    
    static func convertDateToDayOnly (valore: String) -> String {
        
        if (valore.isEmpty) || (valore.characters.count < 8) { return("") }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMDD"
        
        let dateObj = dateFormatter.date(from: valore)
        
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: dateObj!)
    }
    
}
