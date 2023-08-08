//
//  BSECheckbox.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class BSECheckbox: UIView{
    let imageView = UIImageView()
    var isChecked = false {
        didSet{
            imageView.image = isChecked ? UIImage(systemName: "checkmark") : nil
        }
    }
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 4
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        backgroundColor = UIColor(named: "button-bg")
        addSubview(imageView)
        imageView.tintColor = UIColor(named: "button-text")
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
}
