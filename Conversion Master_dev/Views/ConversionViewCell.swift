//
//  ConversionViewCell.swift
//  Conversion Master_dev
//
//  Created by Seth Cohen on 1/8/17.
//  Copyright © 2017 Seth Cohen. All rights reserved.
//

import UIKit

class ConversionViewCell: UITableViewCell {
  @IBOutlet weak var unitType: UILabel!
  @IBOutlet weak var value: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    
    // Configure the view for the selected state
    let view: UIView = UIView()
    view.backgroundColor = UIColor.yellow
    self.selectedBackgroundView = view
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}
