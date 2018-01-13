//
//  BalanceQuarterCell.swift
//  Expandable3
//
//  Created by MAC241 on 11/05/17.
//  Copyright © 2017 KiranJasvanee. All rights reserved.
//

import UIKit

class BalanceQuarterCell: UITableViewCell {

    @IBOutlet weak var imageviewBackground: UIImageView!
    @IBOutlet weak var labelChildAtIndex: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var buttonState: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelChildAtIndex.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    }
    
    func cellFillUp(indexParam: String) {
        labelChildAtIndex.textColor = UIColor.white
        labelChildAtIndex.text = BalanceManager.getQuarterOrMonthNameDependsOn(indexParam)
        valueLabel.text = String(BalanceManager.getCellValueDependsOn(indexParam))
    }
    
}
