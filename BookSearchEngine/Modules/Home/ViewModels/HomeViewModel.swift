//
//  HomeViewModel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation

class HomeViewModel{
    func logout(){
        UserSessionManager.shared.isLoggedIn = false
        AppHelper.setRootVC()
    }
}
