//
//  SayurCollectionViewCell.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class SayurCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var sayurImage: UIImageView!
    @IBOutlet var sayurNameLabel: UILabel!
    @IBOutlet var sayurPrice: UILabel!
    @IBOutlet var buttonTambah: UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
