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
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
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
    
    //MARK: Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton = BSEButton(title: "Let's go", image: UIImage(systemName: "arrow.right"), action: {[weak self] in
            self?.registerUser()
        })
        view.addSubview(scrollView)
        scrollView.addSubview(headerLabel)
        scrollView.addSubview(tfStackView)
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
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 2),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: scrollView.trailingAnchor, constant: -16),
            
            
            tfStackView.leadingAnchor.constraint(equalTo: headerLabel.leadingAnchor),
            tfStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tfStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 15),


            validationItemsStackView.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            validationItemsStackView.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            validationItemsStackView.topAnchor.constraint(equalTo: tfStackView.bottomAnchor, constant: 15),


            countrySelector.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            countrySelector.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            countrySelector.topAnchor.constraint(equalTo: validationItemsStackView.bottomAnchor, constant: 15),
            countrySelector.heightAnchor.constraint(equalToConstant: 140),

            submitButton.leadingAnchor.constraint(equalTo: tfStackView.leadingAnchor),
            submitButton.trailingAnchor.constraint(equalTo: tfStackView.trailingAnchor),
            submitButton.topAnchor.constraint(equalTo: countrySelector.bottomAnchor, constant: 15),
        ])
    }
    
    private func registerUser(){
        //viewmodel:- register will be called
        viewmodel.registerUser()
    }
    
    private func bind(){
        viewmodel.countryList.bind { [weak self] list in
            self?.countryList = list
        }
        viewmodel.emailValidation.bind { [weak self] validation in
            switch validation {
            case .empty:
                break
            case .invalid:
                break
            case .okay:
                break
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
                self?.submitButton.enabled()
            } else{
                self?.submitButton.disabled()
            }
        }
        viewmodel.countryList.bind { [weak self] list in
            self?.countryList = list
            self?.countrySelector.reloadAllComponents()
        }
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
}
