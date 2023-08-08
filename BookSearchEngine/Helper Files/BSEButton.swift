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
        l.font = UIFont(name: "Degular-Semibold", size: 22)
        l.textColor = UIColor(named: "button-text")
        l.textAlignment = .center
        return l
    }()
    
    let imageView = UIImageView()
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 5
        sv.distribution = .fill
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
        layer.borderColor = UIColor.black.cgColor
        backgroundColor = UIColor(named: "button-bg")
        layer.cornerRadius = 12
        clipsToBounds = true
        
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        if image != nil{
            imageView.image = image
            stackView.addArrangedSubview(imageView)
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
}
