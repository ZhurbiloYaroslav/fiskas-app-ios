//
//  ProfileVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {

    //MARK: HEADERS of labels
    @IBOutlet weak var firstNameHeaderLabel: UILabel!
    @IBOutlet weak var lastNameHeaderLabel: UILabel!
    @IBOutlet weak var emailHeaderLabel: UILabel!
    @IBOutlet weak var phoneHeaderLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "profile".localized()
        
        firstNameHeaderLabel.text = "first name".localized()
        lastNameHeaderLabel.text = "last name".localized()
        emailHeaderLabel.text = "email".localized()
        phoneHeaderLabel.text = "phone".localized()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 8
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerTitleText = ""
        
        switch section {
        case 0:
            headerTitleText = "personal info".localized()
        case 1:
            headerTitleText = "Personal info"
        case 2:
            headerTitleText = "Personal info"
        default:
            break
        }
        
        let headerTitle = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerTitle.text = headerTitleText
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = Constants.Color.red
        headerView.addSubview(headerTitle)
        
        return headerView
        
    }

}
