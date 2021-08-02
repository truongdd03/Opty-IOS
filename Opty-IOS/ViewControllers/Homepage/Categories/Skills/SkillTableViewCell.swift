//
//  SkillTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/2/21.
//

import UIKit

class SkillTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var ContentTextView: UITextView!
    
    var name = "" {
        didSet {
            NameLabel.text = name
        }
    }
    
    var content = "" {
        didSet {
            ContentTextView.text = content
        }
    }

}
