//
//  HomeViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class HomeViewController: BSEBaseViewController {
    
    //MARK:  UI components
    
    let headerImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "book.fill")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let headerLabel = BSEHeaderLabel(text: "MedBook")
    
    let titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.text = "Which topic interests \nyou today?"
        l.numberOfLines = 0
        l.font = UIFont(name: "Degular-Medium", size: 28)
        return l
    }()

    let logoutButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Logout", for: .normal)
        b.setTitleColor(.systemRed, for: .normal)
        b.titleLabel?.font = UIFont(name: "Degular-Semibold", size: 18)
        return b
    }()
    
    //MARK:  Class properties
    
    let viewmodel = HomeViewModel()
    
    //MARK:  Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(headerImageView)
        view.addSubview(headerLabel)
        view.addSubview(titleLabel)
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(logoutUser), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            headerImageView.centerYAnchor.constraint(equalTo: headerLabel.centerYAnchor, constant: 1),
            headerImageView.heightAnchor.constraint(equalToConstant: 32),
            headerImageView.widthAnchor.constraint(equalToConstant: 32),
            
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerLabel.leadingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: 10),
            headerLabel.trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: -16),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 30),
            
            logoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    //MARK:  Class Methods
    
    @objc private func logoutUser(){
        viewmodel.logout()
    }
}
