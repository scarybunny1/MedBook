//
//  AppHelper.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class AppHelper{
    static func getRootVC(_ userLoggedIn: Bool = false) -> UIViewController{
        if !userLoggedIn{
            let nc = UINavigationController(rootViewController: LandingViewController())
            return nc
        } else{
            return HomeViewController()
        }
    }
}
