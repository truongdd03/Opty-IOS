//
//  MessageTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/3/21.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet weak var Avatar: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    var name: String? {
        didSet {
            NameLabel.text = name
        }
    }
    var text: String? {
        didSet {
            TextLabel.text = text
        }
    }
    var date: String? {
        didSet {
            DateLabel.text = " - \(date!)"
        }
    }
}
