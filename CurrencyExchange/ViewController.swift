//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Juan Aguillon on 5/6/17.
//  Copyright © 2017 Juan Aguillon. All rights reserved.
//

extension String {

func currencyInputFormatting() -> String {
    
    var number: NSNumber!
    let formatter = NumberFormatter()
    formatter.numberStyle = .currencyAccounting
    formatter.currencySymbol = "$"
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    
    var amountWithPrefix = self
    
    // remove from String: "$", ".", ","
    let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
    amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count), withTemplate: "")
    
    let double = (amountWithPrefix as NSString).doubleValue
    number = NSNumber(value: (double / 100))
    
    // if first number is 0 or all numbers were deleted
    guard number != 0 as NSNumber else {
        return ""
    }
    
    return formatter.string(from: number)!
}
    
}

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate, UIScrollViewAccessibilityDelegate {
    
    var initialHome: [String] = ["US Dollar"]
    var initialForeign: [String] = ["Mexican Peso"]

    @IBOutlet weak var initialHomeLabel: UILabel!
  
    @IBOutlet weak var initialForeignLabel: UILabel!
    @IBOutlet weak var currencyInput: UITextField!
    @IBOutlet weak var convertionResults: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialHomeLabel.text = initialHome[0]
        initialForeignLabel.text = initialForeign[0]
        convertionResults.isHidden = true
        
        func mycurrency(_ textField: UITextField) {
            
            if let amountString1 = currencyInput.text?.currencyInputFormatting() {
                currencyInput.text = amountString1
            }
        }
        
        
    }
    
    
    @IBAction func refreshView(_ sender: UIButton) {
        
        //viewDidLoad()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func Convert(_ sender: UIButton) {
        
        convertionResults.isHidden = false
        
        let amount = Double(currencyInput.text!)
        
        
        let myYQL = YQL()
        let queryString = "select * from yahoo.finance.xchange where pair in (\"USDMXN\")"
        
        
        // This code was provided by the instructor
        myYQL.query(queryString) { jsonDict in
            
            let queryDict = jsonDict["query"] as! [String: Any]
            print(queryDict["count"]!)
            print(queryDict["results"]!)
            
            let results = queryDict["results"] as! [String: Any]
            let rate = results["rate"] as! [String: Any]
            let unitRate = rate["Rate"] as! String
            let calculation = Double(unitRate)! * amount!
            
            DispatchQueue.main.async() {
                self.convertionResults.text="Foreign Currency $\(calculation)"
            }
            
            
            print(rate)
            
            print(unitRate)
            print(calculation)
        }
        
    }


}

