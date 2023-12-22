//
//  ProteinCollectionViewCell.swift
//  SayurKu
//
//  Created by Pungki Busneri on 07/12/23.
//

import UIKit

class ProteinCollectionViewCell: UICollectionViewCell {
    @IBOutlet var proteinImage: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelPrice: UILabel!
    @IBOutlet var buttonTambah: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
