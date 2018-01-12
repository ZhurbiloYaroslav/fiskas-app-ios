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
    @IBOutlet weak var incomeValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateCell() {
        buyValueLabel.text = String(BalanceManager.shared.total.buy)
        sellValueLabel.text = String(BalanceManager.shared.total.sell)
        incomeValueLabel.text = String(BalanceManager.shared.total.income)
    }
    
}
