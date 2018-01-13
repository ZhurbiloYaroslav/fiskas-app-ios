//
//  BalanceInfoCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalancePeriodCell: UITableViewCell {
    
    @IBOutlet weak var headerLabelForPeriod: UILabel!
    @IBOutlet weak var datePickerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {
        
        headerLabelForPeriod.text = "balance_period".localized()
        datePickerButton.setTitle("change_period".localized(), for: .normal)
    }
    
}

