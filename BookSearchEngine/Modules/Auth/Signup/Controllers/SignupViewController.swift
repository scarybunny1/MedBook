//
//  SignupViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class SignupViewController: BSEBaseViewController {
    
    //MARK:  UI components
    let headerLabel = BSEHeaderLabel(text: "Welcome \nsign up to continue")
    var countryList: [String] = []
    
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
        sv.spacing = 15
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.keyboardType = .emailAddress
        tf.borderStyle = .roundedRect
        tf.font = UIFont(name: "Degular-Medium", size: 16)
        tf.tag = 1
        tf.returnKeyType = .next
        tf.textContentType = .none
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.font = UIFont(name: "Degular-Medium", size: 16)
        tf.tag = 2
        tf.returnKeyType = .done
        tf.textContentType = .none

        return tf
    }()
    
    let validationItemsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    let validationItems = [BSEValidatorItem(title: "Atleast 8 characters"),
                           BSEValidatorItem(title: "Must contain an uppercase letter"),
                           BSEValidatorItem(title: "Contains a special character")]
    
    let countrySelector = UIPickerView()
    var submitButton: BSEButton!
    let scrollView = UIScrollView()
    
    //MARK:  Class properties
    
    private var viewmodel = SignupViewModel()
    private var emailValidated = false
    private var passwordValidated = false
    private var enableSubmitButton: Bool {
        emailValidated && passwordValidated
    }
    
    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton = BSEButton(title: "Let's go", image: UIImage(systemName: "arrow.right"), action: {[weak self] in
            self?.registerUser()
        })
        view.addSubview(scrollView)
        scrollView.addSubview(headerLabel)
        scrollView.addSubview(tfStackView)
        tfStackView.addArrangedSubview(errorLabel)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)

        scrollView.addSubview(validationItemsStackView)
        validationItems.forEach { item in
            validationItemsStackView.addArrangedSubview(item)
        }
        scrollView.addSubview(countrySelector)
        scrollView.addSubview(submitButton)
        
        countrySelector.dataSource = self
        countrySelector.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        countrySelector.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 2),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: -16),
            
            
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
            
            tfStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor, constant: 10),
            tfStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tfStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),


            validationItemsStackView.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            validationItemsStackView.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            validationItemsStackView.topAnchor.constraint(equalTo: tfStackView.bottomAnchor, constant: 25),


            countrySelector.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            countrySelector.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            countrySelector.topAnchor.constraint(equalTo: validationItemsStackView.bottomAnchor, constant: 25),
            countrySelector.heightAnchor.constraint(equalToConstant: 140),

            submitButton.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            submitButton.topAnchor.constraint(equalTo: countrySelector.bottomAnchor, constant: 25),
        ])
    }
    
    private func registerUser(){
        viewmodel.email = emailTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        viewmodel.password = passwordTF.text?.trimmingCharacters(in: .whitespaces) ?? ""
        viewmodel.country = countryList[countrySelector.selectedRow(inComponent: 0)]
        viewmodel.registerUser()
    }
    
    private func bind(){
        viewmodel.countryList.bind { [weak self] list in
            self?.countryList = list
        }
        viewmodel.emailValidation.bind { [weak self] validation in
            switch validation {
            case .empty, .invalid, .userExists:
                self?.emailValidated = false
                self?.showErrorLayout(with: validation.rawValue)
            case .okay:
                self?.emailValidated = true
                self?.hideErrorLayout()
            }
        }
        viewmodel.passwordValidation.bind { [weak self] validation in
            for i in 0..<(self?.validationItems.count ?? 0){
                if validation.compactMap({$0.rawValue}).contains(i){
                    self?.validationItems[i].isSelected = true
                } else{
                    self?.validationItems[i].isSelected = false
                }
            }
            if validation.count == (self?.validationItems.count ?? 0){
                self?.passwordValidated = true
            } else{
                self?.passwordValidated = false
            }
            
            self?.enableButton()
        }
        viewmodel.countryList.bind { [weak self] list in
            self?.countryList = list
            self?.countrySelector.reloadAllComponents()
            let defaultSelectedRow = self?.countryList.firstIndex(of: "India") ?? 0
            self?.countrySelector.selectRow(defaultSelectedRow, inComponent: 0, animated: false)
        }
    }
    
    private func enableButton(){
        enableSubmitButton ? submitButton.enabled() : submitButton.disabled()
    }
    
    private func showErrorLayout(with errorMessage: String){
        errorLabel.text = "*" + errorMessage
        enableButton()
    }
    
    private func hideErrorLayout(){
        errorLabel.text = ""
        enableButton()
    }
}

extension SignupViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        countryList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewmodel.country = countryList[row]
    }
}

extension SignupViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
            return true
        }
        
        if textField == passwordTF{
            viewmodel.validatePasswordInput(text)
        }
        return true
    }
    
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
        }
    }
}
