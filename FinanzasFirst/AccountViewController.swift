//
//  AccountViewController.swift
//  FinanzasFirst
//
//  Created by TACODE on 26/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bankLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let tab = self.tabBarController as? BaseTabBarViewController {
            nameLabel.text = tab.person.fullName
            bankLabel.text = tab.account.name
            amountLabel.text = String(tab.account.amount)
        }
    }

}

