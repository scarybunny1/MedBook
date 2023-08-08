//
//  LandingViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LandingViewController: UIViewController {
    
    //MARK:  View elements
    
    let headerLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont(name: "Degular-Semibold", size: 32)
        l.text = "MedBook"
        return l
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "landing")
        return iv
    }()
    
    let signupButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("SignUp", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 8
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 2
        b.titleLabel?.font = UIFont(name: "Degular-Medium", size: 22)
        b.backgroundColor = UIColor(named: "button-bg")
        return b
    }()
    
    let loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Login", for: .normal)
        b.setTitleColor(.black, for: .normal)
        b.layer.cornerRadius = 8
        b.layer.borderColor = UIColor.black.cgColor
        b.layer.borderWidth = 2
        b.titleLabel?.font = UIFont(name: "Degular-Medium", size: 22)
        b.backgroundColor = UIColor(named: "button-bg")
        return b
    }()
    
    let buttonStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    
    //MARK:  Class Properties
    
    
    
    //MARK:  Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(headerLabel)
        view.addSubview(imageView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(signupButton)
        buttonStackView.addArrangedSubview(loginButton)
        signupButton.addTarget(self, action: #selector(navigateToSignupPage), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(navigateToLoginPage), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            imageView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK:  Class Methods
    
    @objc private func navigateToSignupPage(){
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func navigateToLoginPage(){
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
