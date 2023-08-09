//
//  NetworkManager.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 09/08/23.
//

import Foundation

enum APIError: Error{
    case failedToFetch
}

class NetworkManager{
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void){
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else{
                completion(.failure(APIError.failedToFetch))
                return
            }
            completion(.success(data))
        }).resume()
    }
}
