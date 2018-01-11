//
//  InvoiceVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 25.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

extension InvoiceVC: NetworkManagerDelegate {
    func didLoad(arrayWithInvoices: [Invoice]) {
        self.arrayWithInvoices = arrayWithInvoices
        self.tableView.reloadData()
    }
}

class InvoiceVC: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    var arrayWithInvoices = [Invoice]()
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        updateUILabelsWithLocalizedText()
        setupLeftMenu()
        setupTableView()
        downloadInvoices()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        downloadInvoices()
    }
    
    func setDelegates() {
        networkManager.delegate = self
    }
    
    func downloadInvoices() {
        let invoiceData = NetworkManager.RequestInvoiceData(
            email: CurrentUser.email,
            password: CurrentUser.password
        )
        networkManager.getInvoicesFor(invoiceData) { (errorMessages) in
            //TODO: Make Alert here
        }
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
        return arrayWithInvoices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as? InvoiceCell else {
            return UITableViewCell()
        }
        cell.updateCell(withInvoice: arrayWithInvoices[indexPath.row])
        return cell
    }
}
