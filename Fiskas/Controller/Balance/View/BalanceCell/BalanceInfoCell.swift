//
//  BalanceInfoCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceInfoCell: UITableViewCell {
    
    @IBOutlet weak var headerLabelForUserName: UILabel!
    @IBOutlet weak var valueLabelForUserName: UILabel!
    
    @IBOutlet weak var headerLabelForNip: UILabel!
    @IBOutlet weak var valueLabelForNip: UILabel!
    
    @IBOutlet weak var headerLabelForTaxForm: UILabel!
    @IBOutlet weak var valueLabelForTaxForm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {

        // Info Cell
        headerLabelForUserName.text = "balance_name_of_user".localized()
        valueLabelForUserName.text = CurrentCompany.name
        
        headerLabelForNip.text = "nip".localized()
        valueLabelForNip.text = CurrentCompany.nip
        
        headerLabelForTaxForm.text = "balance_my_tax_form".localized()
        valueLabelForTaxForm.text = CurrentCompany.taxService

    }
    
}

