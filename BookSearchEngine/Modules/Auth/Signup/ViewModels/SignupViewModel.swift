//
//  SignupViewModel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation

enum EmailValidation{
    case empty
    case invalid
    case okay
}

enum PasswordValidation: Int{
    case goodLength = 0
    case uppercasePresent
    case specialPresent
}

class SignupViewModel{
    var countryList: Observable<[String]> = Observable([])
    var emailValidation: Observable<EmailValidation> = Observable(.okay)
    var passwordValidation: Observable<[PasswordValidation]> = Observable([])
    
    
    init(){
        fetchCountryList()
    }
    
    func fetchCountryList(){
        fetchDataFromJSON()
    }
    
    func fetchDataFromJSON() {
        guard let jsonFilePath = Bundle.main.path(forResource: "CountryList", ofType: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            let decoder = JSONDecoder()
            let json = try decoder.decode(CountryResponse.self, from: jsonData)
            countryList.value = json.data.values.compactMap { country in
                country.country
            }.sorted()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func fetchDataFromNetwork(){
        
    }
    
    func validateEmailInput(_ email: String){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else{
            emailValidation.value = .empty
            return
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) {
            emailValidation.value = .invalid
        }
        
        emailValidation.value = .okay
    }
    
    func validatePasswordInput(_ password: String){
        let pass = password.trimmingCharacters(in: .whitespaces)
        passwordValidation.value = []
        if pass.count >= 8{
            passwordValidation.value.append(.goodLength)
        }
        if pass != pass.lowercased(){
            passwordValidation.value.append(.uppercasePresent)
        }
        if pass.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_-")) != nil{
            passwordValidation.value.append(.specialPresent)
        }
    }
    
    func registerUser(){
        
    }
}
