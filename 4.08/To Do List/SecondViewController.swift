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
    
    
    var cityCost: Double = 0.0
    
    func calculateNetPay(offer: JobOffer) -> Int{
        var salary = Int(Double(offer.salary + offer.additionalBenefits) + (Double(offer.match401K) * (0.05)/100) * Double(offer.salary))

        if offer.healthInsurance{
            let healthInsurance = 5280
            salary += healthInsurance
        }
        if offer.publicTransportation{
            salary += 0
        }
        
        let studentLoans = 2400
        let carInsurance = 1322
        let lifeInsurance = 170
        getCityCost(city: offer.city)
        if self.cityCost == 0 {
            self.cityCost = 30000
        }
        var costs = Double(studentLoans) + Double(carInsurance) + self.cityCost
        costs += Double(lifeInsurance)
        
        return Int(Double(salary) - costs)
    }
    
    func getCityCost(city: String){
        if let url = URL(string: "https://www.numbeo.com/cost-of-living/in/" + city.replacingOccurrences(of: " ", with: "-")) {
        
        let request = NSMutableURLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            var food = ""
            var foodPrice1 = 0.0
            var rent = ""
            var rentPrice = 0.0
            var entertainment = ""
            var entertainmentPrice = 0.0
            var utilities = ""
            var utilitiesPrice = 0.0
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let unwrappedData = data {
                    let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                    var stringSeparator = "Meal, Inexpensive Restaurant </td> <td style=\"text-align: right\" class=\"priceValue \">"
                    var stringSeparator1 = "Apartment (1 bedroom) in City Centre </td> <td style=\"text-align: right\" class=\"priceValue \">"
                    var stringSeparatorE = "Fitness Club, Monthly Fee for 1 Adult </td> <td style=\"text-align: right\" class=\"priceValue \">"
                    var stringSeparatorU =  "Basic (Electricity, Heating, Cooling, Water, Garbage) for 915 sq ft Apartment </td> <td style=\"text-align: right\" class=\"priceValue \">"
                    //Copy and paste function and change varibels to get variable names
                    if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparator = "&nbsp;&#36;"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                            
                            if newContentArray.count > 1 {
                                
                                food = newContentArray[0]
                                
                                var foodPrice: String = String(food) //string 12.00
                                if(foodPrice.first == " "){
                                    foodPrice.remove(at: foodPrice.startIndex)
                                }
                                //foodPrice.remove(at: foodPrice.startIndex)
                                
                                foodPrice1 = Double(foodPrice)!
                            }
                        }
                    }
                    //Copy and paste function and change varibels to get variable names
                    if let contentArray = dataString?.components(separatedBy: stringSeparator1) {
                        if contentArray.count > 1 {
                            stringSeparator1 = "&nbsp;&#36;"
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparator1)
                            if newContentArray.count > 1 {
                                rent = newContentArray[0]
                        rent = rent.replacingOccurrences(of: ",", with: "")
                        rent = rent.replacingOccurrences(of: " ", with: "")
                        print(rent)
                        rentPrice = Double(rent)!

                            }
                        }
                    }
                    //Copy and paste function and change varibels to get variable names
                    if let contentArray = dataString?.components(separatedBy: stringSeparatorE) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparatorE = "&nbsp;&#36;"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparatorE)
                            
                            if newContentArray.count > 1 {
                                
                                entertainment = newContentArray[0]
                                entertainment.remove(at: entertainment.startIndex)
                                entertainmentPrice = Double(entertainment)!
                                //print(entertainment)
                            }
                        }
                    }
                    if let contentArray = dataString?.components(separatedBy: stringSeparatorU) {
                        
                        if contentArray.count > 1 {
                            
                            stringSeparatorU = "&nbsp;&#36;"
                            
                            let newContentArray = contentArray[1].components(separatedBy: stringSeparatorU)
                            
                            if newContentArray.count > 1 {
                                
                                utilities = newContentArray[0]
                                utilities.remove(at: utilities.startIndex)
                                utilitiesPrice = Double(utilities)!
                                //print(utilities)
                            }
                        }
                    }
                }
            }
        
            self.cityCost = rentPrice * 12 + foodPrice1 * 1095 + entertainmentPrice * 12 + utilitiesPrice * 12 + 2500
            print("the cost")
            print(self.cityCost)
            }
        task.resume()
        
        
    } else {
    
            return
    }
}
    
    
    @IBAction func add(_ sender: AnyObject) {
        if companyTextField.text! == "" || cityTextField.text! == "" || stateTextField.text! == "" || countryTextField.text == "" || salaryTextField.text! == "" || match401KTextField.text! == "" || otherBenefitsTextField.text! == ""{
            return
        }
        
        let itemsObject = UserDefaults.standard.object(forKey: "JobOffers")
        
        var JobOffers:[String]
        
        let offer = JobOffer(companyName: companyTextField.text!, city: cityTextField.text!, state: stateTextField.text!, country: countryTextField.text!, salary: Int(salaryTextField.text!)!, match401K: Int(match401KTextField.text!)!, healthInsurance: healthInsuranceSwitch.isOn, publicTransportation: publicTransportationSwitch.isOn, additionalBenefits: Int(otherBenefitsTextField.text!)!)
        
        var information: String = ""
        information += "Company Name:\t\t\t" + offer.companyName + "\n"
        information += "City:\t\t\t\t\t\t" + offer.city + "\n"
        information += "State:\t\t\t\t\t\t" + offer.state + "\n"
        information += "Country:\t\t\t\t\t" + offer.country + "\n"
        information += "Salary:\t\t\t\t\t\t" + String(offer.salary) + "\n"
        information += "401K % Match:\t\t\t" + String(offer.match401K) + "\n"
        information += "Net Salary & Benefits: \t$" + String(calculateNetPay(offer: offer))
        
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

