//
//  BuahCollectionViewCell.swift
//  SayurKu
//
//  Created by Pungki Busneri on 07/12/23.
//

import UIKit

class BuahCollectionViewCell: UICollectionViewCell {
    @IBOutlet var buahImage: UIImageView!
    @IBOutlet var buahNameLabel: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var tambahButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
