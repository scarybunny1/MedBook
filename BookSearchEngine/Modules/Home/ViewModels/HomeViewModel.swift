//
//  HomeViewModel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation
import Toast

class HomeViewModel{
    func logout(){
        
        //Show logout message after a delay - after switching from Home screen to Landing screen
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let config = ToastConfiguration(
                direction: .bottom,
                autoHide: true,
                enablePanToClose: true,
                displayTime: 3,
                animationTime: 0.2
            )
            let toast = Toast.text(Constants.logoutMessage, config: config)
            toast.show()
        }
        UserSessionManager.shared.isLoggedIn = false
        AppHelper.setRootVC()
    }
}
