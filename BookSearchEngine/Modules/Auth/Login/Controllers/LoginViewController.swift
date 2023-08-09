//
//  LoginViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LoginViewController: BSEBaseViewController {
    
    //MARK:  UI components
    
    let headerLabel = BSEHeaderLabel(text: Constants.loginPageTitle)
    
    let errorLabel: UILabel = {
        let l = UILabel()
        l.text = ""
        l.textColor = Theme.errorLabelColor
        l.font = Constants.Fonts.errorLabelFont
        l.numberOfLines = 0
        l.textAlignment = .left
        return l
    }()
    
    let tfStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 15
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = Constants.loginPageEmailTFPlaceholder
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.font = Constants.Fonts.textFieldFont
        tf.tag = 1
        tf.returnKeyType = .next
        tf.textContentType = .none
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = Constants.loginPagePasswordTFPlaceholder
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.font = Constants.Fonts.textFieldFont
        tf.tag = 2
        tf.returnKeyType = .done
        tf.textContentType = .none
        return tf
    }()
    
    var submitButton: BSEButton!
    
    //MARK:  Class Properties
    
    private var viewmodel = LoginViewModel()
    private var emailValidated = false
    private var passwordValidated = false
    private var validated: Bool{
        emailValidated && passwordValidated
    }
    
    //MARK:  Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton = BSEButton(title: Constants.loginPageSubmitButtonTitle, image: Constants.Images.arrowRight, action: {[weak self] in
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -16),
            
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
            
            tfStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor, constant: 10),
            tfStackView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: -10),
            tfStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),
            
            submitButton.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK:  Class Methods
    
    private func loginUser(){
        let email = emailTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        let password = passwordTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        viewmodel.loginUser(email: email, password: password)
    }
    
    private func bind(){
        viewmodel.errorMessage.bind { [weak self] validation in
            switch validation {
            case .emailEmpty, .emailInvalid:
                self?.emailValidated = false
                self?.showErrorLayout(with: validation.rawValue)
            case .emailValid:
                self?.emailValidated = true
                self?.hideErrorLayout()
            case .passwordEmpty:
                self?.passwordValidated = false
                self?.showErrorLayout(with: validation.rawValue)
            case .passwordValid:
                self?.passwordValidated = true
                self?.hideErrorLayout()
            case .passwordIncorrect, .noSuchUser:
                self?.showErrorLayout(with: validation.rawValue)
            case .okay:
                break
            }
            self?.enableButton()
        }
    }
    
    private func showErrorLayout(with errorMessage: String){
        errorLabel.text = "*" + errorMessage
    }
    
    private func hideErrorLayout(){
        errorLabel.text = ""
    }
    
    private func enableButton(){
        validated ? submitButton.enabled() : submitButton.disabled()
    }
}

extension LoginViewController: UITextFieldDelegate{
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextTextField = view.viewWithTag(nextTag) as? UITextField {
            nextTextField.becomeFirstResponder()
            
        } else {
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTF{
            let email = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
            viewmodel.validateEmailInput(email)
        } else{
            let password = textField.text?.trimmingCharacters(in: .whitespaces) ?? ""
            viewmodel.validatePasswordInput(password)
        }
    }
}
