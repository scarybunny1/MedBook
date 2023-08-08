//
//  LoginViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    let headerLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Welcome, \nlog in to continue"
        l.numberOfLines = 2
        l.font = UIFont(name: "Degular-Bold", size: 32)
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
    
    let submitButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Login", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 8
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 2
        b.titleLabel?.font = UIFont(name: "Degular-Semibold", size: 22)
        b.backgroundColor = UIColor(named: "button-bg")
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(headerLabel)
        view.addSubview(tfStackView)
        tfStackView.addArrangedSubview(emailTF)
        tfStackView.addArrangedSubview(passwordTF)
        view.addSubview(submitButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
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
}
