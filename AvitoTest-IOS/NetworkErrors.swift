//
//  NetworkErrors.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 19.11.2022.
//

import Foundation

enum NetworkErrors: String, Error {
    
    case invalidURL
    case invalidData
    case decodingError

}
