//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Kshatri, Ajith Singh (CORP) on 3/7/17.
//  Copyright © 2017 Kshatri, Ajith Singh (CORP). All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {


    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var customTheme: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: "default")
        let theme = defaults.bool(forKey: "customTheme")
        tipControl.selectedSegmentIndex = intValue;
        if theme {
          customThemeLoad()
        }
        else{
          defaultTheme()
        }
        defaults.synchronize()
    }
    
    func customThemeLoad(){
        self.view.backgroundColor = UIColor(red: 0.8, green: 0.7, blue: 0.7, alpha: 1.0)
    }

    func defaultTheme(){
    self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeTheme(_ sender: Any) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set(customTheme.isOn, forKey: "customTheme")
        defaults.synchronize()
        if customTheme.isOn{
            customThemeLoad()
        }
        else
        {
        defaultTheme()
        }
        defaults.synchronize()
    }

        @IBAction func onTipChanged(_ sender: Any) {
        let defaults = Foundation.UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "default")
        defaults.synchronize()
    }
}
