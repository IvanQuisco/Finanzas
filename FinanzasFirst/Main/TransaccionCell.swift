//
//  TransaccionCell.swift
//  FinanzasFirst
//
//  Created by TACODE on 30/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit
import FinanzasCore

class TransaccionCell: UITableViewCell {

    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var transactionTypeImageView: UIImageView!
    @IBOutlet weak var validTransactionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(with transaction: Transaction) {
        valueLabel.text = transaction.value.currencyFormat()
        nameLabel.text = transaction.name
        dateLabel.text = getFormattedDate(date: transaction.date)
        categoryImageView.image = geImageForCategory(of: transaction)
        transactionTypeImageView.image = getImageForType(of: transaction)
        
        validTransactionView.backgroundColor = transaction.isValid ? .green : .red
    }
    
    func geImageForCategory(of transaction: Transaction) -> UIImage {
        var imageName = String()
        if let debit = transaction as? Debit {
            switch debit.category {
            case .entertainment:
                imageName = "entertainmentIcon"
            case .food:
                imageName = "foodIcon"
            case .other:
                imageName = "otherIcon"
            case .services:
                imageName = "servicesIcon"
            case .transportation:
                imageName = "transportationIcon"
            }
        }
        
        if let gain = transaction as? Gain {
            switch gain.category {
            case .salary:
                imageName = "salaryIcon"
            case .extra:
                imageName = "extraIcon"
            }
        }
        
        return UIImage(named: imageName) ?? UIImage()
    }
    
    func getImageForType(of transaction: Transaction) -> UIImage {
        if transaction is Debit {
            return UIImage(named: "debitIcon") ?? UIImage()
        }
        return UIImage(named: "gainIcon") ?? UIImage()
    }
    
    func getFormattedDate(date: Date) -> String {
        let dateformat = DateFormatter()
        dateformat.timeZone = TimeZone(identifier: "UTC")
        dateformat.locale = .current
        dateformat.dateFormat = "dd-MM-yyyy hh:mm:ss"
        return dateformat.string(from: date)
    }
}
