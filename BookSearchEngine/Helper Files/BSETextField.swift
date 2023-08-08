//
//  BSETextField.swift
//  BookSearchEngine
//
//  Created by Ayush Bhatt on 08/08/23.
//

import UIKit

protocol BSETextFieldDelegate: AnyObject{
    func textDidChange(_ value: String)
}

class BSETextField: UIView{
    
    private let textField = UITextField()
    private let label: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "Degular-Regular", size: 10)
        return l
    }()
    weak var delegate: BSETextFieldDelegate?
    var text: String{
        textField.text ?? ""
    }
    
    init(placeholder: String = ""){
        super.init(frame: .zero)
        textField.delegate = self
        textField.font = UIFont(name: "Degular-Regular", size: 18)
        textField.placeholder = placeholder
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            
        ])
    }
}

extension BSETextField: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            
            return true
        }
        
        delegate?.textDidChange(text)
        return true
    }
}
