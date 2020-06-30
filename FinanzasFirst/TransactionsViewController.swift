//
//  TransactionsViewController.swift
//  FinanzasFirst
//
//  Created by TACODE on 26/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit
import FinanzasCore

class TransactionsViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    
    var person: Person!
    var account: Account!
    
    var dataSource: [Transaction] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simulateAccount()
    }
    
    private func simulateAccount() {
        guard let tab = self.tabBarController as? BaseTabBarViewController else {
            return
        }
        
        person = tab.person
        account = tab.account
        
        person.account = account
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            if let destViewController = segue.destination as?  UINavigationController {
                if let controller = destViewController.viewControllers.first as? AddTransactionViewController {
                    controller.account = self.account
                    controller.delegate = self
                }
            }
            
        }
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TransaccionCell
        cell.setCell(with: dataSource[indexPath.row])
        return cell
    }
}


extension TransactionsViewController: AddTransactionViewControllerDelegate {
    func didAddTransaction(transaction: Transaction) {
        dataSource.insert(transaction, at: 0)
        
    }
    
    
}
