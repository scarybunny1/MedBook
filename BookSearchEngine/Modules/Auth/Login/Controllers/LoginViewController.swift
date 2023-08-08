//
//  LoginViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LoginViewController: BSEBaseViewController {
    
    //MARK:  UI components
    
    let headerLabel = BSEHeaderLabel(text: "Welcome, \nlog in to continue")
    
    let errorLabel: UILabel = {
        let l = UILabel()
        l.text = ""
        l.textColor = .systemRed
        l.font = UIFont(name: "Degular-Regular", size: 12)
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()
    
    let tfStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        return tf
    }()
    
    var submitButton: BSEButton!
    
    //MARK:  Class Properties
    
    private var viewmodel = LoginViewModel()
    
    //MARK:  Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton = BSEButton(title: "Login", image: UIImage(systemName: "arrow.right"), action: {[weak self] in
            self?.loginUser()
        })
        view.addSubview(headerLabel)
        view.addSubview(tfStackView)
        tfStackView.addArrangedSubview(errorLabel)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)
        view.addSubview(submitButton)
        
        emailTF.delegate = self
        passwordTF.delegate = self
        bind()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -16),
            
            tfStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            tfStackView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            tfStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK:  Class Methods
    
    private func loginUser(){
        //viewmodel:- login will be called
        let email = emailTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = passwordTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        viewmodel.email = email
        viewmodel.password = password
        viewmodel.loginUser()
    }
    
    private func bind(){
        viewmodel.errorMessage.bind { [weak self] validation in
            switch validation {
            case .noSuchUser, .emailEmpty, .passwordEmpty, .emailInvalid, .passwordIncorrect:
                self?.showErrorLayout(with: validation.rawValue)
            case .okay:
                self?.hideErrorLayout()
            }
        }
    }
    
    private func showErrorLayout(with errorMessage: String){
        errorLabel.text = "*" + errorMessage
//        submitButton.disabled()
    }
    
    private func hideErrorLayout(){
        errorLabel.text = ""
//        submitButton.enabled()
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        view.endEditing(true)
    }
}
