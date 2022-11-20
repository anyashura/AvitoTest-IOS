//
//  NetworkErrors.swift
//  AvitoTest-IOS
//
//  Created by Anna Shuryaeva on 19.11.2022.
//

import Foundation

enum NetworkErrors: String, Error {

    case invalidURL = "Invalid URL"
    case invalidData = "Invalid Data"
    case decodingError = "Decoding Failed"
    case noConnection = "No Internet Connection"
}
