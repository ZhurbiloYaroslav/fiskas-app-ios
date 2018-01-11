//
//  InvoiceCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 11.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class InvoiceCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var invoiceImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(withInvoice invoice: Invoice) {
        self.titleLabel.text = invoice.name
        self.dateLabel.text = invoice.date
        self.invoiceImageView.sd_setImage(with: invoice.getImageURL(), placeholderImage: #imageLiteral(resourceName: "logo"))
    }
    
}
