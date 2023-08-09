//
//  SignupViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class SignupViewController: BSEBaseViewController {
    
    //MARK:  UI components
    let headerLabel = BSEHeaderLabel(text: Constants.signupPageTitle)
    var countryList: [String] = []
    
    let errorLabel: UILabel = {
        let l = UILabel()
        l.text = ""
        l.textColor = .systemRed
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
        tf.placeholder = Constants.signupPageEmailTFPlaceholder
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
        tf.placeholder = Constants.signupPagePasswordTFPlaceholder
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.borderStyle = .roundedRect
        tf.font = Constants.Fonts.textFieldFont
        tf.tag = 2
        tf.returnKeyType = .done
        tf.textContentType = .oneTimeCode

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
    let contentView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 22
        sv.distribution = .fill
        sv.alignment = .fill
        return sv
    }()
    
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
        
        submitButton = BSEButton(title: Constants.signupPageSubmitButtonTitle, image: Constants.Images.arrowRight, action: {[weak self] in
            self?.registerUser()
        })
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(headerLabel)
        contentView.addArrangedSubview(tfStackView)
        tfStackView.addArrangedSubview(errorLabel)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)

        contentView.addArrangedSubview(validationItemsStackView)
        validationItems.forEach { item in
            validationItemsStackView.addArrangedSubview(item)
        }
        contentView.addArrangedSubview(countrySelector)
        contentView.addArrangedSubview(submitButton)
        
        countrySelector.dataSource = self
        countrySelector.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        
        bind()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        emailTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            emailTF.heightAnchor.constraint(equalToConstant: 40),
            passwordTF.heightAnchor.constraint(equalToConstant: 40),
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
            let defaultSelectedRow = self?.countryList.firstIndex(of: Constants.defaultCountry) ?? 0
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
