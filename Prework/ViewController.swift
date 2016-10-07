//
//  ViewController.swift
//  Prework
//
//  Created by Hong Ha Vo on 9/26/16.
//  Copyright © 2016 Hong Ha Vo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    var formatter = NumberFormatter()
    
    let tipPercentage = [0.18, 0.2, 0.22]
    //load setting
    func loadSettings() {
        let defaults = UserDefaults.standard
        let iniValue = defaults.integer(forKey: "default_percent")
        tipControl.selectedSegmentIndex = iniValue
        calTips()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let defauls = UserDefaults.standard
        defauls.set(tipControl.selectedSegmentIndex, forKey: "default_percent")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        self.billField.delegate = self
        tipLabel.text = "\(CurrencyUtils.formatNumb()) \(CurrencyUtils.localeCurrency(0))"
        totalLabel.text = tipLabel.text
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWasHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calTips() {
        
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentage[tipControl.selectedSegmentIndex]
        
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    
    
    func keyboardWasShown(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            let moveDistance = self.tipControl.frame.maxY - (self.view.frame.size.height - keyboardFrame.size.height)
            
            if (moveDistance > 0) {
                
                self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y - moveDistance, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        })
    }
    
    func keyboardWasHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        })
    }
    
    
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
}

extension ViewController: UITextFieldDelegate{
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField.text?.isEmpty)! {
            
            let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
            let compSepByCharInSet = string.components(separatedBy: aSet)
            let numberFiltered = compSepByCharInSet.joined(separator: "")
            return string == numberFiltered
        }
        return true
    }
}

