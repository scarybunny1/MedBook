//
//  CountryRequest.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 09/08/23.
//

import Foundation

struct CountryRequest{
    let urlString = "https://api.first.org/data/v1/countries"
    
    
    var request: URLRequest?{
        guard let url = URL(string: urlString) else{
            return nil
        }
        return URLRequest(url: url)
    }
}
