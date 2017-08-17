//
//  FirstViewController.swift
//  ManagementTool
//
//  Created by Giovanni Pozzobon on 07/04/17.
//  Copyright © 2017 Giovanni Pozzobon. All rights reserved.
//

import UIKit
import WebKit

class FirstViewController: UIViewController {
    


    @IBOutlet var mainView: UIView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var myView: UIView!
    
    var webView: WKWebView!

    
    // valori dell'utente
    
    var url : String = ""
    var port : String = ""
    var userName : String = ""
    var userPassword : String = ""
    var protocollo = 1
    var protocolloStringa : String = "https://"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // creo l'oggetto WKWebView con le stesse dimensioni della myView
        self.webView = WKWebView(frame: self.mainView.frame)
        // aggiungo come subview la webView alla myView
        self.myView.addSubview(self.webView)
        
        //aggancia la progressbar
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        // carica i dati utente
        readValueUser()
        
        //Apri la pagina
        loadURL()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // ricarica i dati utente
        readValueUser()
        
        //Apri la pagina
        loadURL()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadURL() {
        // esterno
        //var urlComposto: String = "http://88.36.205.44:8087/OnsalesServerGui_new/"
        
        // interno 
        var urlComposto: String = "http://192.168.0.230:8087/OnsalesServerGui_new/"
        
        //carica la pagina
        if !(self.url=="") {
            urlComposto = "\(self.protocolloStringa)\(self.url):\(self.port)"
            print(urlComposto)
        }
        
        
        let urlDaCaricare = URL(string: urlComposto) // creo un URL partendo dalla stringa
        let request = URLRequest(url: urlDaCaricare!) // creo la richiesta da far effettuare alla webview
        self.webView.load(request) // performo la richiesta
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressBar.isHidden = webView.estimatedProgress == 1 // se la esistematedProgress è == 1, allora passa a true la proprietà Hidden della progressView, rendendola invisibile
            progressBar.bringSubview(toFront: webView)
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true) // altrimenti aumenta il valore della proprietà progress
        }
    }
    
    
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
    
}

