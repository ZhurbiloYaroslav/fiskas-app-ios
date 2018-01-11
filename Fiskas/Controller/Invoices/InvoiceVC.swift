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
        setupTableView()
    }
    
    func setupTableView() {
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UINib(nibName: "InvoiceCell", bundle: nil), forCellReuseIdentifier: "InvoiceCell")
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

extension InvoiceVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as? InvoiceCell else {
            return UITableViewCell()
        }
        return cell
    }
}
