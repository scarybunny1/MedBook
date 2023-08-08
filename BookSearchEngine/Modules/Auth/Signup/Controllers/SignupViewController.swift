//
//  SignupViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class SignupViewController: UIViewController {
    
    let headerLabel = BSEHeaderLabel(text: "Welcome \nsign up to continue")
    
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
    
    let validationItemsStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    let validationItem1 = BSEValidatorItem(title: "Item 1")
    let validationItem2 = BSEValidatorItem(title: "Item 2")
    let validationItem3 = BSEValidatorItem(title: "Itme 3")
    
    let countrySelector = UIPickerView()
    let submitButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Let's go", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 8
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 2
        b.titleLabel?.font = UIFont(name: "Degular-Semibold", size: 22)
        b.backgroundColor = UIColor(named: "button-bg")
        return b
    }()
    
    
    let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(scrollView)
        scrollView.addSubview(headerLabel)
        scrollView.addSubview(tfStackView)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)

        scrollView.addSubview(validationItemsStackView)
        validationItemsStackView.addArrangedSubview(validationItem1)
        validationItemsStackView.addArrangedSubview(validationItem2)
        validationItemsStackView.addArrangedSubview(validationItem3)
        scrollView.addSubview(countrySelector)
        scrollView.addSubview(submitButton)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        countrySelector.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
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
}
