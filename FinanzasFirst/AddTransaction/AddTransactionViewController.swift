//
//  AddTransactionViewController.swift
//  FinanzasFirst
//
//  Created by TACODE on 29/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit
import FinanzasCore

protocol AddTransactionViewControllerDelegate {
    func didAddTransaction(transaction: Transaction)
}

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var transaccionTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var conceptTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    
    var account: Account!
    
    var delegate: AddTransactionViewControllerDelegate?
    
    var pickerView:  UIPickerView!
    
    let debitCategories: [String]  = [
        "",
        DebitCategories.entertainment.rawValue,
        DebitCategories.food.rawValue,
        DebitCategories.other.rawValue,
        DebitCategories.services.rawValue,
        DebitCategories.transportation.rawValue
    ]
    
    let gainCategories: [String] = [
        "",
        GainCategories.salary.rawValue,
        GainCategories.extra.rawValue
    ]
    
    var repetitionFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        categoryTextfield.inputView = pickerView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountTextfield.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountTextfield.endEditing(true)
        conceptTextfield.endEditing(true)
        categoryTextfield.endEditing(true)
    }

    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddButtonTapped(_ sender: Any) {
        
        addTransaction()

    }
    
    @IBAction func transactionTypeChanged(_ sender: Any) {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        self.categoryTextfield.text = ""
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
    func addTransaction() {
        
        
        
        guard let value = amountTextfield.text, !value.isEmpty, let valueFloat = Float(value) else {
                self.presentAlert(title: "Informacion incompleta", subtitle: "inserte un valor")
                return
            }
            
        guard let concept = conceptTextfield.text,!concept.isEmpty else {
            self.presentAlert(title: "Informacion incompleta", subtitle: "Inserte un concepto")
            return
        }
        
        guard let category = categoryTextfield.text, !category.isEmpty else {
            self.presentAlert(title: "Informacion incompleta", subtitle: "seleccione categoria")
            return
        }
        
        guard repetitionFlag == false else {
            return
        }
        repetitionFlag = true
        
        if isDebitSelected() {
            do {
                try account.addTransaction(with: .debit(value: valueFloat, name: concept, category: DebitCategories(rawValue: category) ?? .other, date: Date()), completion: { (transaction) in
                    if let transaction = transaction {
                        self.dismiss(animated: true) {
                            self.delegate?.didAddTransaction(transaction: transaction)
                        }
                    }
                })
            } catch {
                self.repetitionFlag = false
                self.presentAlert(title: "Error", subtitle: error.localizedDescription)
            }
    
        } else {
            do {
                try account.addTransaction(with: .gain(value: valueFloat, name: concept, category: GainCategories(rawValue: category) ?? .extra, date: Date()), completion: { (transaction) in
                    if let transaction = transaction {
                        self.dismiss(animated: true) {
                            self.delegate?.didAddTransaction(transaction: transaction)
                        }
                    }
                })
            } catch {
                self.repetitionFlag = false
                self.presentAlert(title: "Error", subtitle: error.localizedDescription)
            }
        }
    }
    
    func presentAlert(title: String?, subtitle: String ) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func isDebitSelected() -> Bool {
        return transaccionTypeSegmentedControl.selectedSegmentIndex == 0
    }
}


extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if  isDebitSelected(){
            return debitCategories.count
        }
        return gainCategories.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if isDebitSelected() {
            return debitCategories[row]
        }
        return gainCategories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if isDebitSelected() {
            categoryTextfield.text = debitCategories[row]
        } else {
            categoryTextfield.text = gainCategories[row]
        }
        
    }
    
    
}
