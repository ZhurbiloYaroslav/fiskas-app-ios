//
//  BalanceVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController
import KJExpandableTableTree

class BalanceVC: UITableViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var expandButton: UIBarButtonItem!
    
    var arrayTree:[Parent] = []
    var kjtreeInstance: KJTree = KJTree()
    var isKjTreeInitiallyExpanded = false
    var balanceManager = BalanceManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBalanceSheet()
        
        setupLeftMenu()
        updateUILabelsWithLocalizedText()
        getBalanceData()
    }
    
    func getBalanceData() {
        
        let requestBalanceData = NetworkManager.RequestBalanceData(
            email: CurrentUser.email,
            password: CurrentUser.password
        )
        
        NetworkManager().getBalanceFor(requestBalanceData) { errorMessages in
            if let errorMessages = errorMessages {
                Alert().presentAlertWith(messages: errorMessages, completionHandler: { alertController in
                    self.present(alertController, animated: true, completion: nil)
                })
            } else {
                self.balanceManager = BalanceManager.shared
                self.setupBalanceSheet()
                self.tableView.reloadData()
            }
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
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "balance".localized()
        expandButton.title = "button_nav_expand".localized()
        
    }
    
    func setupBalanceSheet() {
        
        kjtreeInstance = balanceManager.getKJTree()
        
        kjtreeInstance.isInitiallyExpanded = isKjTreeInitiallyExpanded
        kjtreeInstance.animation = .fade
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 170
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    @IBAction func expandCollapseButtonPressed(_ sender: UIBarButtonItem) {
        if kjtreeInstance.isInitiallyExpanded {
            isKjTreeInitiallyExpanded = false
        } else {
            isKjTreeInitiallyExpanded = true
        }
        setupBalanceSheet()
        tableView.reloadData()
    }
    
    @IBAction func refreshDataButtonPressed(_ sender: UIButton) {
        getBalanceData()
    }
    
    @objc func showPeriodPicker(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ChangePeriod", sender: nil)
    }
    
    @IBAction func makePhotoButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowMakePhoto", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else {
            return
        }
        if segueID == "ChangePeriod" {
            guard let balancePeriodVC = segue.destination as? BalancePeriodVC else { return }
            balancePeriodVC.delegate = self
        } else if segueID == "ShowMakePhoto" {
            
        }
    }
    
}

extension BalanceVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            let numberOfRows = kjtreeInstance.tableView(tableView, numberOfRowsInSection: section)
            return numberOfRows
        case 2:
            return 1
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
            
        case (1,_):
            switch indexPath.row {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActualCell", for: indexPath) as? BalanceActualCell
                    else { return UITableViewCell() }
                cell.updateCell()
                return cell
            case (kjtreeInstance.tableView(tableView, numberOfRowsInSection: 1) - 1):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "PeriodCell", for: indexPath) as? BalancePeriodCell
                    else { return UITableViewCell() }
                cell.datePickerButton.addTarget(self, action: #selector(self.showPeriodPicker(_:)), for: .touchUpInside)
                return cell
            default:
                return getBalanceCellForTable(tableView, withIndexPath: indexPath)
            }
            
        case (2,0): // TotalCell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BalanceTotal", for: indexPath) as? BalanceTotalCell
                else { return UITableViewCell() }
            cell.updateCell()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            print("was pressed cell with indexPath: ", indexPath)
        case 1:
            let node = kjtreeInstance.tableView(tableView, didSelectRowAt: indexPath)
        case 2:
            print("was pressed cell with indexPath: ", indexPath)
        default:
            print("was pressed undefined cell with indexPath: ", indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerTitleText = ""
        
        switch section {
            
        case 0:
            headerTitleText = "balance_info_section".localized()
            
        case 1:
            headerTitleText = "balance_balance_section".localized()
            
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
        case 2:
            return 1
        default:
            return 30
        }
    }
}

extension BalanceVC {
    
    func getBalanceCellForTable(_ tableView: UITableView, withIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let node = kjtreeInstance.cellIdentifierUsingTableView(tableView, cellForRowAt: indexPath)
        let indexTuples = node.index.components(separatedBy: ".")
        
        if indexTuples.count == 1 {
            
            // Parents
            let cellIdentifierParents = "BalanceCategoryCellIdentity"
            var cellParents: BalanceCategoryCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? BalanceCategoryCell
            if cellParents == nil {
                tableView.register(UINib(nibName: "BalanceCategoryCell", bundle: nil), forCellReuseIdentifier: cellIdentifierParents)
                cellParents = tableView.dequeueReusableCell(withIdentifier: cellIdentifierParents) as? BalanceCategoryCell
            }
            cellParents?.cellFillUp(indexParam: node.index)
            cellParents?.selectionStyle = .none
            
            if node.state == .open {
                cellParents?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            } else if node.state == .close {
                cellParents?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            } else {
                cellParents?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellParents!
            
        } else if indexTuples.count == 2 {
            
            // Parents
            let cellIdentifierChilds = "BalanceQuarterCellIdentity"
            var cellChild: BalanceQuarterCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? BalanceQuarterCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "BalanceQuarterCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? BalanceQuarterCell
            }
            cellChild?.cellFillUp(indexParam: node.index)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        } else if indexTuples.count == 3 {
            
            // Parents
            let cellIdentifierChilds = "BalanceMonthCellIdentity"
            var cellChild: BalanceMonthCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? BalanceMonthCell
            if cellChild == nil {
                tableView.register(UINib(nibName: "BalanceMonthCell", bundle: nil), forCellReuseIdentifier: cellIdentifierChilds)
                cellChild = tableView.dequeueReusableCell(withIdentifier: cellIdentifierChilds) as? BalanceMonthCell
            }
            cellChild?.cellFillUp(indexParam: node.index)
            cellChild?.selectionStyle = .none
            
            if node.state == .open {
                cellChild?.buttonState.setImage(UIImage(named: "minus"), for: .normal)
            }else if node.state == .close {
                cellChild?.buttonState.setImage(UIImage(named: "plus"), for: .normal)
            }else{
                cellChild?.buttonState.setImage(nil, for: .normal)
            }
            
            return cellChild!
            
        } else {
            // Childs
            // grab cell
            var tableviewcell = tableView.dequeueReusableCell(withIdentifier: "cellidentity")
            if tableviewcell == nil {
                tableviewcell = UITableViewCell(style: .default, reuseIdentifier: "cellidentity")
            }
            tableviewcell?.textLabel?.text = node.index
            tableviewcell?.backgroundColor = UIColor.yellow
            tableviewcell?.selectionStyle = .none
            return tableviewcell!
        }
    }
}

extension BalanceVC: BalancePeriodVcDelegate {
    func userChosePeriod(_ period: BalanceManager.BalancePeriod) {
        let lastRowNumber = kjtreeInstance.tableView(tableView, numberOfRowsInSection: 1) - 1
        guard let cell = tableView.cellForRow(at: [1,lastRowNumber]) as? BalancePeriodCell else { return }
        cell.datePickerButton.setTitle(period.getPeriod(), for: .normal)
    }
}

