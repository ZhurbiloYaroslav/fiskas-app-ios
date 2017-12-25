//
//  InvoiceVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 25.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

class InvoiceVC: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
        setupLeftMenu()
    }
    
    func updateUILabelsWithLocalizedText() {
        navigationItem.title = "invoices".localized()
    }
    
    func setupLeftMenu() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

}
