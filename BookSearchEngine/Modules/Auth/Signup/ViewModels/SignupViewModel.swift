//
//  SignupViewModel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import Foundation

enum EmailValidation: String{
    case empty = "Email is required."
    case invalid = "Email is invalid."
    case okay = ""
    case userExists = "User already exists."
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
    
    var email = ""
    var password = ""
    var country = ""
    
    init(){
        fetchCountryList()
    }
    
    func fetchCountryList(){
        if Reachability.isInternetAvailable() {
            fetchDataFromNetwork()
        } else{
            fetchDataFromJSON()
        }
    }
    
    func fetchDataFromJSON() {
        guard let jsonFilePath = Bundle.main.path(forResource: "CountryList", ofType: "json") else {
            return
        }
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: jsonFilePath))
            decodeData(jsonData: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }

    func fetchDataFromNetwork(){
        guard let countryRequest = CountryRequest().request else{
            self.fetchDataFromJSON()
            return
        }
        NetworkManager.shared.fetchData(request: countryRequest) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.decodeData(jsonData: data)
                }
            case .failure:
                self?.fetchDataFromJSON()
            }
        }
    }
    
    func decodeData(jsonData: Data){
        do {
            let decoder = JSONDecoder()
            let json = try decoder.decode(CountryResponse.self, from: jsonData)
            countryList.value = json.data.values.compactMap { country in
                country.country
            }.sorted()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func validateEmailInput(_ email: String){
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else{
            emailValidation.value = .empty
            return
        }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        guard emailPredicate.evaluate(with: email) else {
            emailValidation.value = .invalid
            return
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
        if let user = User.getUser(email: email){
            emailValidation.value = .userExists
        } else{
            User.addUser(email: email, password: password, country: country)
            UserSessionManager.shared.isLoggedIn = true
            AppHelper.setRootVC()
        }
    }
}
