//
//  BalanceTotalCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 25.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceTotalCell: UITableViewCell {
    
    @IBOutlet weak var sellHeaderLabel: UILabel!
    @IBOutlet weak var buyHeaderLabel: UILabel!
    @IBOutlet weak var incomeHeaderLabel: UILabel!
    
    @IBOutlet weak var sellValueLabel: UILabel!
    @IBOutlet weak var buyValueLabel: UILabel!
    @IBOutlet weak var incomeValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateCell() {
        sellHeaderLabel.text = "balance_sell".localized() // Sprzedaż
        buyHeaderLabel.text = "balance_buy".localized() // Zakup
        incomeValueLabel.text = "balance_income".localized() // Zysk
        
        sellValueLabel.text = String(BalanceManager.shared.total.sell)
        buyValueLabel.text = String(BalanceManager.shared.total.buy)
        incomeValueLabel.text = String(BalanceManager.shared.total.income)
    }
    
}
