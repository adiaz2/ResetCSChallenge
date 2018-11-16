//
//  JobOffer.swift
//  To Do List
//
//  Created by Alejandro Diaz on 11/15/18.
//  Copyright © 2018 Appfish. All rights reserved.
//

import Foundation
class JobOffer {
    var companyName: String
    var city: String
    var state: String
    var country: String
    var salary: Int
    var match401K: Int
    var healthInsurance: Bool
    var publicTransportation: Bool
    var additionalBenefits: Int
    
    init(companyName: String, city: String, state: String, country: String, salary: Int, match401K: Int, healthInsurance: Bool, publicTransportation: Bool, additionalBenefits: Int) {
        self.companyName = companyName
        self.city = city
        self.state = state
        self.country = country
        self.salary = salary
        self.match401K = match401K
        self.healthInsurance = healthInsurance
        self.publicTransportation = publicTransportation
        self.additionalBenefits = additionalBenefits
    }
}
