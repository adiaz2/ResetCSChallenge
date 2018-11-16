//
//  SecondViewController.swift
//  To Do List
//
//  Created by Rob Percival on 17/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {
    
    // All of the Job Offer Information form inputs
    @IBOutlet var companyTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var salaryTextField: UITextField!
    @IBOutlet var match401KTextField: UITextField!
    @IBOutlet var healthInsuranceSwitch: UISwitch!
    @IBOutlet var publicTransportationSwitch: UISwitch!
    @IBOutlet var otherBenefitsTextField: UITextField!
    
    @IBAction func add(_ sender: AnyObject) {
        
        let itemsObject = UserDefaults.standard.object(forKey: "JobOffers")
        
        var JobOffers:[String]
        
        let offer = JobOffer(companyName: companyTextField.text!, city: cityTextField.text!, state: stateTextField.text!, country: countryTextField.text!, salary: Int(salaryTextField.text!)!, match401K: Int(match401KTextField.text!)!, healthInsurance: healthInsuranceSwitch.isOn, publicTransportation: publicTransportationSwitch.isOn, additionalBenefits: Int(otherBenefitsTextField.text!)!)
        
        var information: String = ""
        information += "Name\t" + offer.companyName + "\n"
        information += "City\t" + offer.city + "\n"
        information += "State\t" + offer.state + "\n"
        information += "Country\t" + offer.country + "\n"
        information += "Salary\t" + String(offer.salary) + "\n"
        information += "401K % Match\t" + String(offer.match401K) + "\n"
        information += "Additional Benefits\t" + String(offer.additionalBenefits)
        
        if let tempItems = itemsObject as? [String] {
            
            JobOffers = tempItems
                             
            JobOffers.append(information)
            
            print(information)
            
        } else {
            JobOffers = [information]
        }
        
        
        UserDefaults.standard.set(JobOffers, forKey: "JobOffers")
        
        companyTextField.text = ""
        cityTextField.text = ""
        stateTextField.text = ""
        countryTextField.text = ""
        salaryTextField.text = ""
        match401KTextField.text = ""
        healthInsuranceSwitch.setOn(false, animated: true)
        publicTransportationSwitch.setOn(false, animated: true)
        otherBenefitsTextField.text = ""
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

