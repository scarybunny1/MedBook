//
//  BSECheckbox.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

class BSECheckbox: UIView{
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    var isChecked = false {
        didSet{
            imageView.image = isChecked ? UIImage(systemName: "checkmark") : UIImage(systemName: "xmark")
        }
    }
    
    init() {
        super.init(frame: .zero)
        layer.cornerRadius = 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
        backgroundColor = UIColor(named: "button-bg")
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
