//
//  ProfileVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

class ProfileVC: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    //MARK: HEADERS of labels
    @IBOutlet weak var firstNameHeaderLabel: UILabel!
    @IBOutlet weak var lastNameHeaderLabel: UILabel!
    @IBOutlet weak var emailHeaderLabel: UILabel!
    @IBOutlet weak var phoneHeaderLabel: UILabel!
    
    @IBOutlet weak var companyNameHeaderLabel: UILabel!
    @IBOutlet weak var nipHeaderLabel: UILabel!
    @IBOutlet weak var regonHeaderLabel: UILabel!
    @IBOutlet weak var bankNameHeaderLabel: UILabel!
    @IBOutlet weak var accountNumberHeaderLabel: UILabel!
    @IBOutlet weak var companyEmailHeaderLabel: UILabel!
    @IBOutlet weak var companyPhoneHeaderLabel: UILabel!
    @IBOutlet weak var taxServiceHeaderLabel: UILabel!
    
    @IBOutlet weak var passwordHeaderLabel: UILabel!
    @IBOutlet weak var pushNotificationsHeaderLabel: UILabel!
    @IBOutlet weak var privacyPolicyHeaderLabel: UILabel!
    @IBOutlet weak var deleteAccountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
        setupLeftMenu()
        
//        self.automaticallyAdjustsScrollViewInsets = false;
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "personal info".localized()
        
        firstNameHeaderLabel.text = "first name".localized()
        lastNameHeaderLabel.text = "last name".localized()
        emailHeaderLabel.text = "email".localized()
        phoneHeaderLabel.text = "phone".localized()
        
        companyNameHeaderLabel.text = "company name".localized()
        nipHeaderLabel.text = "nip".localized()
        regonHeaderLabel.text = "regon".localized()
        bankNameHeaderLabel.text = "bank name".localized()
        accountNumberHeaderLabel.text = "account number".localized()
        companyEmailHeaderLabel.text = "email".localized()
        companyPhoneHeaderLabel.text = "phone".localized()
        taxServiceHeaderLabel.text = "tax service".localized()
        
        passwordHeaderLabel.text = "password".localized()
        pushNotificationsHeaderLabel.text = "push notifications".localized()
        privacyPolicyHeaderLabel.text = "privacy policy".localized()
        deleteAccountLabel.text = "delete account".localized()
        
    }
    
    func setupLeftMenu() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
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
            return UIView()
        case 1:
            headerTitleText = "company info".localized()
        case 2:
            headerTitleText = "options".localized()
        default:
            break
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        headerView.backgroundColor = Constants.Color.red
        
        let headerTitleLabel = UILabel(frame: CGRect(x: 15, y: 3, width: tableView.frame.size.width, height: 30))
        headerTitleLabel.text = headerTitleText
        headerTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        headerTitleLabel.textColor = UIColor.white
        headerView.addSubview(headerTitleLabel)
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return CGFloat.leastNormalMagnitude
        default:
            return 30
        }
    }

}
