//
//  LandingViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class LandingViewController: UIViewController {
    
    //MARK:  View elements
    
    let headerLabel = BSEHeaderLabel(text: "MedBook")
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "landing")
        return iv
    }()
    
    var signupButton: BSEButton!
    
    var loginButton: BSEButton!
    
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
        
        loginButton = BSEButton(title: "Login", action: {[weak self] in
            self?.navigateToLoginPage()
        })
        
        signupButton = BSEButton(title: "Signup", action: {[weak self] in
            self?.navigateToSignupPage()
        })
        
        view.backgroundColor = UIColor(named: "background")
        view.addSubview(headerLabel)
        view.addSubview(imageView)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(signupButton)
        buttonStackView.addArrangedSubview(loginButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func navigateToSignupPage(){
        let vc = SignupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToLoginPage(){
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
