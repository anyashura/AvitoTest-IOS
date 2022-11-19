//
//  Model.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 16.11.2022.
//

import Foundation

struct Response: Codable {
    let company: Company
}

struct Company: Codable {
    let name: String
    let employees: [Employee]
}

struct Employee: Codable {
    let name: String
    let phoneNumber: String
    let skills: [String]
            
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
