//
//  BalanceTotalCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 25.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceTotalCell: UITableViewCell {
    
    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var sellValueLabel: UILabel!
    @IBOutlet weak var thirdValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        updateCell()
    }
    
    func updateCell() {
        buyValueLabel.text = "0$"
        sellValueLabel.text = "0$"
        thirdValueLabel.text = "0$"
    }
    
}
