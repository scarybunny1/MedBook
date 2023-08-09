//
//  Constants.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

struct Constants{
    
    static let langingPageTitle = "MedBook"
    static let landingPageLoginButtonTitle = "Login"
    static let landingPageSignupButtonTitle = "Signup"
    static let loginPageEmailTFPlaceholder = "Email"
    static let loginPagePasswordTFPlaceholder = "Password"
    static let loginPageSubmitButtonTitle = "Login"
    static let loginPageTitle = "Welcome, \nlog in to continue"
    
    static let signupPageTitle = "Welcome \nsign up to continue"
    static let signupPageEmailTFPlaceholder = "Email"
    static let signupPagePasswordTFPlaceholder = "Password"
    static let signupPageSubmitButtonTitle = "Let's go"
    
    static let homePageHeaderTitle = "MedBook"
    static let homePageTitle = "Which topic interests \nyou today?"
    
    static let defaultCountry = "India"
    static let logoutMessage = "Logged Out Successfully"
    
    struct Fonts{
        static let errorLabelFont = UIFont(name: "Degular-Regular", size: 12)
        static let textFieldFont = UIFont(name: "Degular-Medium", size: 16)
        static let titleFont = UIFont(name: "Degular-Medium", size: 28)
    }
    
    struct Images{
        static let landingPageImage = UIImage(named: "landing")
        static let homePageHeaderImage = UIImage(systemName: "book.fill")
        static let arrowRight = UIImage(systemName: "arrow.right")
    }
}

struct Theme{
    
}
