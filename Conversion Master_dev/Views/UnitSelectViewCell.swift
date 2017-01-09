//
//  UnitSelectViewCell.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/7/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

import UIKit

class UnitSelectViewCell: UICollectionViewCell {
    
  @IBOutlet weak var unitTypeLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    layer.borderColor = UIColor(colorLiteralRed:0xB2/255.0, green:0xB2/255.0, blue:0x00/255.0, alpha:1).cgColor
  }
}
