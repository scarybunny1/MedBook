//
//  AppHelper.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class AppHelper{
    static func getRootVC() -> UIViewController{
        if UserSessionManager.shared.isLoggedIn{
            return HomeViewController()
        } else{
            let nc = UINavigationController(rootViewController: LandingViewController())
            return nc
        }
    }
    
    static func setRootVC(){
        if UserSessionManager.shared.isLoggedIn{
            keyWindow?.rootViewController = HomeViewController()
        } else{
            let nc = UINavigationController(rootViewController: LandingViewController())
            keyWindow?.rootViewController = nc
        }
    }
}
