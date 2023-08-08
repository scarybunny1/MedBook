//
//  BSEValidatorItem.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class BSEValidatorItem: UIView{
    
    let checkbox = BSECheckbox()
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Degular-Semibold", size: 18)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private var title: String
    
    var isSelected = false{
        didSet{
            checkbox.isChecked = isSelected
        }
    }
    
    init(title: String){
        self.title = title
        super.init(frame: .zero)
        addSubview(checkbox)
        addSubview(titleLabel)
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkbox.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5)
        ])
    }
}
