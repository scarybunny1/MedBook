//
//  BSEButton.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

enum Padding{
    case top(Int)
    case bottom(Int)
    case left(Int)
    case right(Int)
    case horizontal(Int)
    case vertical(Int)
}

class BSEButton: UIView{
    let titleLabel: UILabel = {
        let l = UILabel()
        l.font = Constants.Fonts.buttonTextFont
        l.textColor = Theme.buttonTextColor
        l.textAlignment = .center
        return l
    }()
    
    let imageView = UIImageView()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        return sv
    }()
    
    
    var title: String
    var action: () -> Void
    var image: UIImage?
    
    init(title: String, image: UIImage? = nil, action: @escaping (() -> Void) = {}){
        self.title = title
        self.action = action
        self.image = image
        super.init(frame: .zero)
        
        layer.borderWidth = 2
        layer.borderColor = Theme.buttonTextColor?.cgColor ?? UIColor.black.cgColor
        backgroundColor = Theme.buttonBackground
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(stackView)
        
        if image != nil{
            stackView.addArrangedSubview(UIView())
            stackView.addArrangedSubview(UIView())
            stackView.addArrangedSubview(titleLabel)
            imageView.image = image
            imageView.tintColor = Theme.appTintColor
            imageView.contentMode = .scaleAspectFit
            stackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(UIView())
        } else{
            stackView.addArrangedSubview(titleLabel)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func viewTapped(){
        action()
    }
    
    private func configure(){
        imageView.image = image
        titleLabel.text = title
    }
    
    func disabled(){
        isUserInteractionEnabled = false
        titleLabel.textColor = Theme.buttonDisabledTextColor
        imageView.tintColor = Theme.buttonDisabledTextColor
        layer.borderColor = Theme.buttonDisabledTextColor?.cgColor ?? UIColor.black.cgColor
    }
    
    func enabled(){
        isUserInteractionEnabled = true
        titleLabel.textColor = Theme.buttonTextColor
        imageView.tintColor = .black
        layer.borderColor = Theme.buttonTextColor?.cgColor ?? UIColor.black.cgColor
    }
}
