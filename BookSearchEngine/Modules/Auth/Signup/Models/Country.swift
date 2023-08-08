//
//  Country.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 09/08/23.
//

import Foundation

struct CountryResponse: Codable{
    var data: [String: Country]
}

struct Country: Codable{
    let country: String
    let region: String
}
