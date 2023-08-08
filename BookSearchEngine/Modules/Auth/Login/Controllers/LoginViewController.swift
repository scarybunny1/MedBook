//
//  LoginViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let headerLabel = BSEHeaderLabel(text: "Welcome, \nlog in to continue")
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton = BSEButton(title: "Login", image: UIImage(systemName: "arrow.right"), action: {[weak self] in
            self?.loginUser()
        })
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(headerLabel)
        view.addSubview(tfStackView)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)
        view.addSubview(submitButton)
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
    
    private func loginUser(){
        //viewmodel:- login will be called
    }
}
