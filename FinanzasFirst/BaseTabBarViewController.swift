//
//  BaseTabBarViewController.swift
//  FinanzasFirst
//
//  Created by TACODE on 30/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit
import FinanzasCore

class BaseTabBarViewController: UITabBarController {

    var person: Person!
    var account: Account!
    
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
