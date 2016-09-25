//
//  SettingsViewController.swift
//  Prework
//
//  Created by Hong Ha Vo on 9/26/16.
//  Copyright © 2016 Hong Ha Vo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    

    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let iniValue = defaults.integer(forKey: "default_percent")
        tipControl.selectedSegmentIndex = iniValue;
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSegmentChanged(_ sender: AnyObject) {
        defaults.set(tipControl.selectedSegmentIndex, forKey: "default_percent")
        defaults.synchronize()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
