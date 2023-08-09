//
//  BSEHeaderLabel.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class BSEHeaderLabel: UILabel{
    
    init(text: String){
        super.init(frame: .zero)
        self.text = text
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func configure(){
        numberOfLines = 0
        font = UIFont(name: "Degular-Bold", size: 32)
    }
}
