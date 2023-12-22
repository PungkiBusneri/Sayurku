//
//  SayaTableViewCell.swift
//  SayurKu
//
//  Created by Pungki Busneri on 21/12/23.
//

import UIKit

class SayaTableViewCell: UITableViewCell {
    
    @IBOutlet var imageViewCell: UIImageView!
    @IBOutlet var labelCell: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
