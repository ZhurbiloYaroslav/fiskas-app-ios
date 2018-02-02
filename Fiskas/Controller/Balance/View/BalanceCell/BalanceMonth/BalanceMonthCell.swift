//
//  BalanceMonthCell.swift
//  Expandable3
//
//  Created by MAC241 on 11/05/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

class BalanceMonthCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var buttonState: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
    }

    func cellFillUp(indexParam: String) {
        
        titleLabel.textColor = UIColor.white
        titleLabel.text = BalanceManager.getQuarterOrMonthNameDependsOn(indexParam)
        valueLabel.text = String(BalanceManager.getCellValueDependsOn(indexParam)) + " " + Constants.currency
    }
    
}
