//
//  UserSessionManager.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation

class UserSessionManager{
    static let shared = UserSessionManager()
    
    private let userDefaults = UserDefaults.standard
    
    var isLoggedIn: Bool{
        get{
            userDefaults.bool(forKey: "is-user-logged-in")
        }
        set{
            userDefaults.set(newValue, forKey: "is-user-logged-in")
        }
    }
}
