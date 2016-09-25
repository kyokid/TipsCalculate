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
    
    let tipPercentage = [0.18, 0.2, 0.22]
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        billField.becomeFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSettings()
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
    
    
    
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
}

