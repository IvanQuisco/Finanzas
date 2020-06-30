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
    
    var dataSource: [Transaction] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simulateAccount()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateDataSource()
    }
    
    
    func updateDataSource() {
        dataSource.removeAll()
        for transaction in account.gains {
            dataSource.append(transaction)
        }
        
        for transaction in account.debits {
            dataSource.append(transaction)
        }
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
    
    private func simulateAccount() {
        person = Person(name: "Juan", lastName: "Perez")
        account = Account(amount: 1_500, name: "Santander")
        
        person.account = account
        
        for transaction in account.gains {
            dataSource.append(transaction)
        }
        
        for transaction in account.debits {
            dataSource.append(transaction)
        }
        
        do {
             try account.addTransaction(with: .debit(value: 200, name: "Dulces", category: .food, date: Date(year: 2019, month: 10, day: 21)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .debit(value: 45, name: "Refresco", category: .food, date: Date(year: 2019, month: 10, day: 22)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .debit(value: 100, name: "Uber", category: .transportation, date: Date(year: 2019, month: 10, day: 23)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .debit(value: 120, name: "Netflix", category: .entertainment, date: Date(year: 2019, month: 10, day: 25)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
            try account.addTransaction(with: .debit(value: 200, name: "Gasto random", category: .other, date: Date(year: 2019, month: 10, day: 27)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .debit(value: 300, name: "Electricidad", category: .services, date: Date(year: 2019, month: 10, day: 30)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .gain(value: 1000, name: "Salario Octubre 1", category: .salary, date: Date(year: 2019, month: 10, day: 30)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
        
        do {
             try account.addTransaction(with: .gain(value: 500, name: "Pryecto", category: .extra, date: Date(year: 2019, month: 10, day: 30)), completion: { transaction in
                if let transaction = transaction {
                    self.dataSource.insert(transaction, at: 0)
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            })
        } catch {
            print("error en la transaccion", error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTransaction" {
            if let destViewController = segue.destination as?  UINavigationController {
                if let controller = destViewController.viewControllers.first as? AddTransactionViewController {
                    controller.account = self.account
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
