//
//  MenuCell.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 04.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuItemIconImage: UIImageView!
    @IBOutlet weak var menuItemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func updateCellWith(indexPath: IndexPath) {
        
        switch indexPath {
        case [0,0]:
            updateLabelsWith(image: "icon-balance", andTitle: "balance".localized())
        case [0,1]:
            updateLabelsWith(image: "icon-camera", andTitle: "make_photo".localized())
        case [0,2]:
            updateLabelsWith(image: "icon-contacts", andTitle: "contacts".localized())
        case [0,3]:
            updateLabelsWith(image: "icon-profile", andTitle: "profile".localized())
        case [0,4]:
            updateLabelsWith(image: "icon-message", andTitle: "report_a_problem".localized())
        case [0,5]:
            updateLabelsWith(image: "icon-logout", andTitle: "log_out".localized())
        default:
            break
        }
        
    }
    
    private func updateLabelsWith(image: String, andTitle title: String) {
        menuItemIconImage.image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        menuItemIconImage.tintColor = Constants.Color.red
        menuItemNameLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
