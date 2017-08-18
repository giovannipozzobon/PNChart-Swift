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

    @IBOutlet weak var queryPointOrderText: UITextField!
    
    @IBOutlet weak var queryPointCustomerText: UITextField!
    
    @IBOutlet weak var queryPointSalesText: UITextField!
    
    @IBOutlet weak var IndirizzoonSalesServerText: UITextField!
    
    var userDefault: UserDefaultUtility = UserDefaultUtility()
    
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

        
        if !self.urlText.text!.isEmpty {
            userDefault.url = self.urlText.text!
        }
        
        if !self.portText.text!.isEmpty {
            userDefault.port = self.portText.text!
        }
        
        
        if !self.userNameText.text!.isEmpty {
            userDefault.userName = self.userNameText.text!
        }
        
        if !self.userPasswordText.text!.isEmpty  {
            userDefault.userPassword = self.userPasswordText.text!
        }

        if !self.queryPointOrderText.text!.isEmpty  {
            userDefault.queryPointOrder = self.queryPointOrderText.text!
        }
        
        if !self.queryPointCustomerText.text!.isEmpty  {
            userDefault.queryPointCustomer = self.queryPointCustomerText.text!
        }

        if !self.queryPointSalesText.text!.isEmpty  {
            userDefault.queryPointSales = self.queryPointSalesText.text!
        }

        if !self.IndirizzoonSalesServerText.text!.isEmpty  {
            userDefault.urlServerGUI = self.IndirizzoonSalesServerText.text!
        }
        
        userDefault.protocollo = self.protocolloSwitch.selectedSegmentIndex
        
        userDefault.saveValueUser()
        
    }

    func readValueUser() {
        
        userDefault.readValueUser()
        
        self.urlText.text = userDefault.url
        
        self.portText.text = userDefault.port
       
        self.userNameText.text = userDefault.userName
        
        self.userPasswordText.text = userDefault.userPassword
        
        self.queryPointOrderText.text = userDefault.queryPointOrder
        
        self.queryPointCustomerText.text = userDefault.queryPointCustomer
        
        self.queryPointSalesText.text = userDefault.queryPointSales
        
        self.IndirizzoonSalesServerText.text = userDefault.urlServerGUI
        
        self.protocolloSwitch.setEnabled(true, forSegmentAt: userDefault.protocollo)
        
        
    }
    

}
    

