//
//  Model.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import Foundation

struct Company: Codable {
    var company: Employees
}

struct Employees: Codable {
    var name: String
    var employees: [Employee]
}

struct Employee: Codable {
    var name: String
    var phoneNumber: String
    var skills: [String]
            
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}

