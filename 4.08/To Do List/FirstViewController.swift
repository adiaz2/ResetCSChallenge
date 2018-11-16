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

    var jobOffers: [JobOffer] = []

    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return jobOffers.count
        
    }
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        //TODO: put the contents of the job offer object to a cell
        let offer = jobOffers[indexPath.row]
        var information: String = ""
        information += "Name\t" + offer.companyName + "\n"
        information += "City\t" + offer.city + "\n"
        information += "State\t" + offer.state + "\n"
        information += "Country\t" + offer.country + "\n"
        information += "Salary\t" + String(offer.salary) + "\n"
        information += "401K % Match\t" + String(offer.match401K) + "\n"
        information += "Additional Benefits\t" + String(offer.additionalBenefits)
        
        cell.textLabel?.text = "Test"
        
        return cell
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "JobOffers")
        
        
        if let tempItems = itemsObject as? [JobOffer] {
            
            jobOffers = tempItems
            
        }
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            jobOffers.remove(at: indexPath.row)
            
            table.reloadData()
            
            UserDefaults.standard.set(jobOffers, forKey: "JobOffers")
            
        }
        
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

