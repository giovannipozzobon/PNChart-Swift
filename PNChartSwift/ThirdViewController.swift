//
//  ThirdViewController.swift
//  ManagementTool
//
//  Created by Giovanni Pozzobon on 07/04/17.
//  Copyright © 2017 Giovanni Pozzobon. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var urlText: UITextField!
    @IBOutlet weak var portText: UITextField!
    @IBOutlet weak var protocolloSwitch: UISegmentedControl!
    @IBOutlet weak var userPasswordText: UITextField!
    @IBOutlet weak var userNameText: UITextField!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // caricamento delle opzioni di default
        readValueUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        var url : String = ""
        var port : String = ""
        var userName : String = ""
        var userPassword : String = ""
        
        if !self.urlText.text!.isEmpty {
            url = self.urlText.text!
        }
        
        if !self.portText.text!.isEmpty {
            port = self.portText.text!
        }
        
        
        if !self.userNameText.text!.isEmpty {
            userName = self.userNameText.text!
        }
        
        if !self.userPasswordText.text!.isEmpty  {
            userPassword = self.userPasswordText.text!
        }

        //chiama la routine di salvataggio
        self.saveValueUser(url:url,port:port,userName:userName,userPassword:userPassword, protocollo: self.protocolloSwitch.selectedSegmentIndex)
        
    }
    
    func saveValueUser(url: String, port:String, userName: String, userPassword: String, protocollo: Int) {
        
        let defaults = UserDefaults.standard
        
        defaults.set(url, forKey: "URL")
        defaults.set(port, forKey: "Port")
        defaults.set(userName, forKey: "UserName")
        defaults.set(userPassword, forKey: "UserPassword")
        defaults.set(protocollo, forKey: "Protocollo")
        
        // stampa le stringhe lette
        print(url)
        print(port)
        print(userName)
        print(userPassword)
        print(protocollo)
        
    }

    
    func readValueUser() {
        
        let defaults = UserDefaults.standard
        
        if let url = defaults.string(forKey: "URL") {
            print(url)
            self.urlText.text = url
        }
        
        if let port = defaults.string(forKey: "Port") {
            print(port)
            self.portText.text = port
        }
        
        if let userName = defaults.string(forKey: "UserName") {
            print(userName)
            self.userNameText.text = userName
        }
        
        if let userPassword = defaults.string(forKey: "UserPassword")  {
            print(userPassword)
            self.userPasswordText.text = userPassword
        }
        
        var protocollo = 0
        if !(defaults.object(forKey: "Protocollo") == nil)  {
            protocollo = defaults.integer(forKey: "Protocollo")
            print(protocollo)

            self.protocolloSwitch.setEnabled(true, forSegmentAt: protocollo)

        }
        
    }
    
        
}
    

