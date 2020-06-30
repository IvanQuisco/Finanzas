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
    
    var emptyStateView: UIImageView = {
        let image = UIImage(named: "emptyState")?.withRenderingMode(.alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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
        let count = dataSource.count
        tableView.backgroundView = count == 0 ? emptyStateView : nil
        tableView.separatorStyle = count == 0 ? .none : .singleLine
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! TransaccionCell
        cell.setCell(with: dataSource[indexPath.row])
        return cell
    }
}

extension TransactionsViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let action = UITableViewRowAction(style: .default, title: "Invalidate") { (action, indexpath) in
//            print("let's invalidate this")
//        }
//        action.backgroundColor = .purple
//        return [action]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let invalidate = UIContextualAction(style: .normal, title: "Invalidate") { (_, _, _) in
            print("let's invalidate this")
            
            self.dataSource[indexPath.row].invalidateTransaction { (succeeded) in
                if succeeded {
                    DispatchQueue.main.async {
                        tableView.reloadData()
                    }
                }
            }
        }
        invalidate.backgroundColor = .purple
        let swipeActions = UISwipeActionsConfiguration(actions: [invalidate])
        return swipeActions
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return dataSource[indexPath.row].isValid
    }
    
    

}


extension TransactionsViewController: AddTransactionViewControllerDelegate {
    func didAddTransaction(transaction: Transaction) {
        dataSource.insert(transaction, at: 0)
    }
}
