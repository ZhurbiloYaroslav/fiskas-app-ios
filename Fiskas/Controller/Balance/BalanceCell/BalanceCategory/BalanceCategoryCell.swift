//
//  BalanceCategoryCell.swift
//  Expandable3
//
//  Created by MAC241 on 11/05/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

class BalanceCategoryCell: UITableViewCell {

    @IBOutlet weak var imageviewBackground: UIImageView!
    @IBOutlet weak var labelParentCell: UILabel!
    
    @IBOutlet weak var buttonState: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        labelParentCell.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
    }
    
    func cellFillUp(indexParam: String) {
        labelParentCell.text = "BalanceCategoryCell"
        
    }
    
}
