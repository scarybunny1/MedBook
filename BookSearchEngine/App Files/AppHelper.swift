//
//  AppHelper.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class AppHelper{
    static func getRootVC() -> UIViewController{
        var userLoggedIn = false
        if !userLoggedIn{
            let nc = UINavigationController(rootViewController: LandingViewController())
            return nc
        } else{
            return HomeViewController()
        }
    }
}
