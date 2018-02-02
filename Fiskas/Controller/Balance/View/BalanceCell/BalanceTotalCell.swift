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
    
    @IBOutlet weak var makePhotoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateCell() {
        sellHeaderLabel.text = "balance_sell".localized() // Sprzedaż
        buyHeaderLabel.text = "balance_buy".localized() // Zakup
        incomeHeaderLabel.text = "balance_income".localized() // Zysk
        
        sellValueLabel.text = String(BalanceManager.shared.total.sell)  + " " + Constants.currency
        buyValueLabel.text = String(BalanceManager.shared.total.buy)  + " " + Constants.currency
        incomeValueLabel.text = String(BalanceManager.shared.total.income)  + " " + Constants.currency
        
        makePhotoButton.setTitle("make_photo".localized(), for: .normal)
    }
    
}
