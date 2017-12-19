//
//  BalanceSheetCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceSheetCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCellWith(_ indexPath: IndexPath) {
        let category = Balance().items[indexPath.row]
        categoryLabel.text = category.name
        valueLabel.text = category.getStringWithTotalValue()
    }

}
