//
//  CustomTableViewCell.swift
//  Crypteux
//
//  Created by Aiman on 2021/07/15.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var coinPrice: UILabel!
    @IBOutlet weak var coinAbbrev: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
