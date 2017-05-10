//
//  listOfCurrencies.swift
//  CurrencyExchange
//
//  Created by CampusUser on 5/9/17.
//  Copyright © 2017 Juan Aguillon. All rights reserved.
//

import Foundation

import UIKit

class listOfCurrencies: UITableViewController {
    
    var currencyList: [String] = []
    
    override func viewDidLoad() {
        
        currencyList=["US Dollar","Mexican Peso","Japanese Yen","British Pound","Canadian Dollar","European Union Euro","Chinese Yuan"]
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text=currencyList[indexPath.row]
        
        return cell
    }
}
