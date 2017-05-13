//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Juan Aguillon on 5/6/17.
//  Copyright © 2017 Juan Aguillon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, UIScrollViewAccessibilityDelegate {
    
    var initialHome: [String] = ["US Dollar"]
    var initialForeign: [String] = ["Mexican Peso"]

    @IBOutlet weak var initialHomeLabel: UILabel!
  
    @IBOutlet weak var initialForeignLabel: UILabel!
    @IBOutlet weak var currencyInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialHomeLabel.text = initialHome[0]
        initialForeignLabel.text = initialForeign[0]
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Convert(_ sender: UIButton) {
        
        //var rate : Double
        
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"USDMXN\")"
        
        // Network session is asyncronous so use a closure to act upon data once data is returned
        myYQL.query(queryString) { jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
            print(queryDict["count"]!)
            print(queryDict["results"]!)
            
            let results = queryDict["results"] as! [String: Any]
            let rate = results["rate"] as! [String: Any]
            let test = rate["Rate"] as! String
            print(rate)
            
            print(test)
        }
        
    }


}

