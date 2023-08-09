//
//  BSEBaseViewController.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 09/08/23.
//

import UIKit

class BSEBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        backButton.tintColor = Theme.appTintColor
        navigationItem.backBarButtonItem = backButton
        view.backgroundColor = UIColor(named: "background")
    }

    @objc func handleTap() {
        self.view.endEditing(true)
    }

}
