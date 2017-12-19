//
//  BalanceVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

struct Period {
    var fromDate: String
    var toDate: String
    func getPeriod() -> String {
        return fromDate + " - " + toDate
    }
}

class BalanceVC: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
        setupLeftMenu()
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "balance".localized()
        
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else {
            return
        }
        if segueID == "ChangePeriod" {
            guard let balancePeriodVC = segue.destination as? BalancePeriodVC else { return }
            balancePeriodVC.delegate = self
        }
    }
    
    func setupLeftMenu() {
        if revealViewController() != nil {
            //            revealViewController().rearViewRevealWidth = 62
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 4
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0): // InfoCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? BalanceInfoCell
                else { return UITableViewCell() }
            return cell
        case (1,_): // SheetCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SheetCell", for: indexPath) as? BalanceSheetCell
                else { return UITableViewCell() }
            cell.updateCellWith(indexPath)
            return cell
        case (2,0): // InvoiceCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceCell", for: indexPath) as? BalanceInvoiceCell
                else { return UITableViewCell() }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerTitleText = ""
        
        switch section {
        case 0:
            headerTitleText = "balance_info_section_title"
        case 1:
            headerTitleText = "balance_sheet_section_title"
        case 2:
            headerTitleText = "balance_receipts_section_title"
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
        return 30
    }
    
}

extension BalanceVC: BalancePeriodVcDelegate {
    func userChosePeriod(_ period: Period) {
        guard let cell = tableView.cellForRow(at: [0,0]) as? BalanceInfoCell else { return }
        cell.datePickerButton.setTitle(period.getPeriod(), for: .normal)
    }
}

