//
//  PostTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 8/11/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var ApplicantsNumberLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var CompanyLabel: UILabel!
    @IBOutlet weak var AddressLabel: UILabel!
    @IBOutlet weak var ContentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
