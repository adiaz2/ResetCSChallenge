//
//  FirstViewController.swift
//  To Do List
//
//  Created by Rob Percival on 17/06/2016.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!

    var jobOffers: [String] = []

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortJobOffers()
        return jobOffers.count
        
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        //TODO: put the contents of the job offer object to a cell
        sortJobOffers()
        let offer = jobOffers[indexPath.row]
//        var information: String = ""
//        information += "Name\t" + offer.companyName + "\n"
//        information += "City\t" + offer.city + "\n"
//        information += "State\t" + offer.state + "\n"
//        information += "Country\t" + offer.country + "\n"
//        information += "Salary\t" + String(offer.salary) + "\n"
//        information += "401K % Match\t" + String(offer.match401K) + "\n"
//        information += "Additional Benefits\t" + String(offer.additionalBenefits)
        
        cell.textLabel?.text = offer
        
        return cell
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 200
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "JobOffers")
        
        
        if let tempItems = itemsObject as? [String] {
            
            jobOffers = tempItems
            
        }
        
        table.reloadData()
    }
    
    func getSalary(offer: String) -> Int{
        var i = 1
        while Int(offer.suffix(i)) != nil{
            i += 1
        }
        return Int(offer.suffix(i-1))!
    }
    
    func sortJobOffers(){
        if jobOffers.count < 1{
            return
        }
        for i in 0..<jobOffers.count - 1{
            for j in 0..<jobOffers.count - i - 1{
                if getSalary(offer: jobOffers[j]) < getSalary(offer: jobOffers[j+1]){
                    let temp = jobOffers[j];
                    jobOffers[j] = jobOffers[j+1];
                    jobOffers[j+1] = temp;
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            jobOffers.remove(at: indexPath.row)
            sortJobOffers()
            
            table.reloadData()
            
            UserDefaults.standard.set(jobOffers, forKey: "JobOffers")
            
        }
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

