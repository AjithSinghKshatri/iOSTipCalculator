//
//  ViewController.swift
//  TipCalculator
//
//  Created by Kshatri, Ajith Singh (CORP) on 3/6/17.
//  Copyright © 2017 Kshatri, Ajith Singh (CORP). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    // Persist bill amount across app restarts for 10 minutes
    static let billAmountTimeToLive = TimeInterval(10 * 60)
    static let defaults = UserDefaults.standard
    
    let currencyFormatter = NumberFormatter()
    func settings(){
        let intValue = ViewController.defaults.integer(forKey: "default")
        tipControl.selectedSegmentIndex = intValue;
        let theme = ViewController.defaults.bool(forKey: "customTheme")
        calculateTip(Any.self)
        if theme{
        self.view.backgroundColor = UIColor(red: 0.8, green: 0.7, blue: 0.7, alpha: 1.0)
        }
        else {
        self.view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        currencyFormatter.locale = Locale.current
        currencyFormatter.numberStyle = .currency
        tipLabel.text = currencyFormatter.string(from: 0)
        totalLabel.text = currencyFormatter.string(from: 0)
        tipLabel.adjustsFontSizeToFitWidth = true
        totalLabel.adjustsFontSizeToFitWidth = true
        billField.adjustsFontSizeToFitWidth = true
        ViewController.defaults.set(false, forKey: "customTheme")
        ViewController.defaults.synchronize()
        if getLastBill() == 0 {
        billField.text = nil
        }
        else {
            billField.text = String(getLastBill())
        }
         billField.becomeFirstResponder()
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(_ sender: Any) {
       view.endEditing(true)
    }
    
    @IBAction func tipvalueChanged(_ sender: Any) {
        calculateTip(Any.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        settings()
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    

    
    @IBAction func calculateTip(_ sender: Any) {
        
    
        let tipPercentages = [0.15, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        updateViewWithAnimation(_animated: true)
        setLastBill(bill: bill)
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        tipLabel.text = currencyFormatter.string(from: NSNumber(value:  tip))
        totalLabel.text = currencyFormatter.string(from: NSNumber(value:  total))
        
    }
    

    func updateViewWithAnimation(_animated:Bool) {
         let bill = Double(billField.text!) ?? 0
        
    // Animation when bill value is entered total and tip value alpha is increased
    if (bill != 0) {
    UIView.animate(withDuration: 0.4, animations: {
        self.tipLabel.alpha=1
        self.totalLabel.alpha=1
        })
    }
    // Animation when bill value is zero total and tip value alpha is increased
    else{
        UIView.animate(withDuration: 0.4, animations: {
            self.tipLabel.alpha=0.2
            self.totalLabel.alpha=0.2
        })
        }
    }

    func getLastBill() -> Double {
        let now = NSDate()
        let lastBillTimestamp = ViewController.defaults.object(forKey: "last_bill_timestamp") as! NSDate?
        let isBillAmountExpired = lastBillTimestamp == nil || now.timeIntervalSince(lastBillTimestamp as! Date) > ViewController.billAmountTimeToLive
        if isBillAmountExpired {
            return 0
        } else {
            return ViewController.defaults.double(forKey: "last_bill")
        }
    }
    
    func setLastBill(bill: Double) {
        ViewController.defaults.set(bill, forKey: "last_bill")
        ViewController.defaults.set(NSDate(), forKey: "last_bill_timestamp")
        ViewController.defaults.synchronize()
    }

    
}

