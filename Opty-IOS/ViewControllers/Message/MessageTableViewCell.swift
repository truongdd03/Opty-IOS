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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
