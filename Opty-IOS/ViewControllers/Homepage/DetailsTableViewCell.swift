//
//  DetailsTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/29/21.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var CellLabel: UILabel!
    
    var cellLabel = "" {
        didSet {
            CellLabel.text = cellLabel
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
