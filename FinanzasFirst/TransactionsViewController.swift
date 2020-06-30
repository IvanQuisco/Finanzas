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
    
    private func simulateAccount() {
        person = Person(name: "Juan", lastName: "Perez")
        account = Account(amount: 1_500, name: "Santander")
        
        person.account = account
    }
}

extension TransactionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        return cell
    }
    
    
}
