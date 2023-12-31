//
//  LoginViewModel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation

enum LoginValidation: String{
    case noSuchUser = "There's no such user."
    case emailEmpty = "Email is required."
    case passwordEmpty = "Password is required."
    case emailInvalid = "Email is invalid."
    case passwordIncorrect = "Password is incorrect."
    case emailValid
    case passwordValid
    case okay
}

class LoginViewModel{
    var email: String = ""
    var password: String = ""
    
    var errorMessage: Observable<LoginValidation> = Observable(.okay)
    
    @discardableResult
    func validateEmailInput(_ email: String) -> Bool{
        guard !email.isEmpty else{
            errorMessage.value = .emailEmpty
            return false
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else{
            errorMessage.value = .emailInvalid
            return false
        }
        errorMessage.value = .emailValid
        return true
    }
    
    @discardableResult
    func validatePasswordInput(_ password: String) -> Bool{
        guard !password.isEmpty else{
            errorMessage.value = .passwordEmpty
            return false
        }
        
        errorMessage.value = .passwordValid
        return true
    }
    
    func loginUser(email: String, password: String){
        if validateEmailInput(email) && validatePasswordInput(password){
            //user login
            guard let user = User.getUser(email: email) else{
                errorMessage.value = .noSuchUser
                return
            }
            if password == user.password{
                UserSessionManager.shared.isLoggedIn = true
                AppHelper.setRootVC()
            } else{
                errorMessage.value = .passwordIncorrect
                return
            }
        }
    }
}
