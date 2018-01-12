//
//  BalanceInfoCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceActualCell: UITableViewCell {
    
    @IBOutlet weak var headerLabelForActualization: UILabel!
    @IBOutlet weak var valueLabelForActualization: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell() {
        headerLabelForActualization.text = "balance_last_actual_time".localized()
        valueLabelForActualization.text = BalanceManager.shared.actualization
    }
    
}

