//
//  AddTransactionViewController.swift
//  FinanzasFirst
//
//  Created by TACODE on 29/06/20.
//  Copyright © 2020 tacode. All rights reserved.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var conceptTextfield: UITextField!
    @IBOutlet weak var categoryTextfield: UITextField!
    
    
    let categories = ["", "Food", "Entertainment", "Transportation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pickerView =  UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        categoryTextfield.inputView = pickerView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        amountTextfield.endEditing(true)
        conceptTextfield.endEditing(true)
        categoryTextfield.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountTextfield.becomeFirstResponder()
    }

    @IBAction func CancelButtonTapped(_ sender: Any) {
        self.dismiss()
    }
    @IBAction func AddButtonTapped(_ sender: Any) {
        //AddTransaccion
        self.dismiss()
    }
    
    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}


extension AddTransactionViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    
}
