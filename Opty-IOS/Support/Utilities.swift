//
//  Utilities.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.systemBlue.cgColor
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleSimpleTextField(textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemBlue.cgColor
        textField.layer.cornerRadius = 5
    }
    
    static func styleTextView(textView: UITextView) {
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemBlue.cgColor
        textView.layer.cornerRadius = 5
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 15.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    static func sizeOfLabel(_ str: String) -> CGFloat {
        let label = UILabel()
        label.text = str
            
        return label.intrinsicContentSize.width
    }
}
