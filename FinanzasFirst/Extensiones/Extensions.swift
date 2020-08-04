//
//  Extensions.swift
//  FinanzasFirst
//
//  Created by TACODE on 30/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import Foundation

extension Float {
    func currencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter.string(from: NSNumber(value: self))!
    }
}
