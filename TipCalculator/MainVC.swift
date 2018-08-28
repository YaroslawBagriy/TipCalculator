//
//  MainVC.swift
//  TipCalculator
//
//  Created by Yaroslaw Bagriy on 3/28/16.
//

import UIKit

class MainVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var subtotalEntry: UITextField!
    @IBOutlet weak var selectedTip: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var numOfPeople: UITextField!
    @IBOutlet weak var tipPerPerson: UILabel!
    @IBOutlet weak var perPersonText: UILabel!
    @IBOutlet weak var startOverButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        subtotalEntry.delegate = self
        numOfPeople.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        
        // get value of slider
        let currentValue = Int(slider.value)
        
        // update display text with slider value
        selectedTip.text = "\(currentValue)%"
        
    }
    
    @IBAction func calTipPressed(_ sender: AnyObject) {
        
        // check fields for values before proceeding
        if subtotalEntry.text == "" {
            subtotalEntry.text = "0.00"
        }
        
        if numOfPeople.text == "" {
            numOfPeople.text = "1" // assume 1 person
        }
        
        tipPerPerson.isHidden = false
        perPersonText.isHidden = false
        startOverButton.isHidden = false
        
        // set temp variables to compute
        let subtotal = Float(subtotalEntry.text!)
        let split = Float(numOfPeople.text!)
        let perc = Float(slider.value)
        
        // perform calculation
        
        let result = (subtotal! * (perc / 100) / split!)
        let result2 = String(format: "%.2f", result)
        
        tipPerPerson.text = "$\(result2)"
        
        dismissKeyboard()
    }
    
    @IBAction func startOverPressed(_ sender: AnyObject) {
        
        // restore default app settings
        tipPerPerson.isHidden = true
        perPersonText.isHidden = true
        startOverButton.isHidden = true
        subtotalEntry.text = nil
        selectedTip.text = "20%"
        slider.value = 20
        numOfPeople.text = nil
        
        dismissKeyboard()
    }
    
    func dismissKeyboard() {
        
        subtotalEntry.resignFirstResponder()
        numOfPeople.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        
        dismissKeyboard()
        
    }

}

