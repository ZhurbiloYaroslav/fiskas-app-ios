//
//  InvoiceCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 11.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import UIKit

class InvoiceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var invoiceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        updateCell()
    }
    
    func updateCell() {
        self.titleLabel.text = "Test title"
        self.dateLabel.text = "11.01.2018"
        self.invoiceImageView.image = #imageLiteral(resourceName: "logo")
    }
    
}
