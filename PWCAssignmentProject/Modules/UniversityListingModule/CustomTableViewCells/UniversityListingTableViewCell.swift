//
//  UniversityListingTableViewCell.swift
//  PWCAssignmentProject
//
//  Created by Afaq Ahmad on 10/5/23.
//

import UIKit

class UniversityListingTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(content: ListingConfigs) {
        nameLabel.text = content.name
        stateLabel.text = content.stateProvince?.rawValue
    }

}
