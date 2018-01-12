//
//  BalanceMonthCell.swift
//  Expandable3
//
//  Created by MAC241 on 11/05/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

class BalanceMonthCell: UITableViewCell {

    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonState: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
    }

    func cellFillUp(indexParam: String) {
        
        labelTitle.textColor = UIColor.white
        labelTitle.text = BalanceManager.getQuarterOrMonthNameDependsOn(indexParam)
    }
    
}
