//
//  DegreeTableViewCell.swift
//  Opty-IOS
//
//  Created by Dong Truong on 7/30/21.
//

import UIKit

class DegreeTableViewCell: UITableViewCell {

    @IBOutlet weak var SchoolLabel: UILabel!
    @IBOutlet weak var DegreeLabel: UILabel!
    @IBOutlet weak var StartLabel: UILabel!
    @IBOutlet weak var EndLabel: UILabel!
    
    var schoolName = "" {
        didSet {
            SchoolLabel.text = schoolName
        }
    }
    var degreeName = "" {
        didSet {
            DegreeLabel.text = degreeName
        }
    }
    var startDate = "" {
        didSet {
            StartLabel.text = startDate
        }
    }
    var endDate = "" {
        didSet {
            EndLabel.text = endDate
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
