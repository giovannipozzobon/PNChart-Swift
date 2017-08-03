//
//  ExchangeData.swift
//  PNChartSwift
//
//  Created by Giovanni Pozzobon on 12/05/17.
//
//

import Foundation

class ExchageData : NSObject {


    var chartType : String = ""
    
    var arrGraphRes = [[String:AnyObject]]() //Array dei valori ritornati

    var arrTopOrderRes = [[String:AnyObject]]() //Array dei valori ritornati
    
    var arrTopUserRes = [[String:AnyObject]]() //Array dei valori ritornati
    
    //Indicatore di caricamento dei dati JSon
    var graphLoaded : Bool = false;
    var topOrderLoaded : Bool = false;
    var topUserLoaded : Bool = false;



 }
