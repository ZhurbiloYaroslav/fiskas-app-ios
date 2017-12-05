//
//  ContactsVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

class ContactsVC: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var fullAddressTextLabel: UILabel!
    
    @IBOutlet weak var addressHeaderLabel: UILabel!
    
    @IBOutlet weak var contactsHeaderLabel: UILabel!
    @IBOutlet weak var phoneHeaderLabel: UILabel!
    @IBOutlet weak var emailHeaderLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
        setupLeftMenu()

    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "contacts".localized()
        
        fullAddressTextLabel.text = "full address".localized()
        addressHeaderLabel.text = "address".localized()
        phoneHeaderLabel.text = "phone".localized()
        emailHeaderLabel.text = "email".localized()
        
    }
    
    func setupLeftMenu() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    @IBAction func makePhoneCall1(_ sender: UIButton) {
        Browser.openURLWith(.Call_555_549)
    }
    
    @IBAction func sendEmailButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Mail_Kancelaria_Fiskas)
    }
    
}
