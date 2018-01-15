//
//  BalancePeriodVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol BalancePeriodVcDelegate: class {
    
    func userChosePeriod(_ period:BalanceManager.BalancePeriod)
    
}

class BalancePeriodVC: UIViewController {
    
    @IBOutlet weak var dateFromLabel: UILabel!
    @IBOutlet weak var dateToLabel: UILabel!
    @IBOutlet weak var chooseButton: UIButton!
    
    weak var delegate: BalancePeriodVcDelegate?

    @IBOutlet weak var datePicker_From: UIDatePicker!
    @IBOutlet weak var datePicker_To: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {
        dateFromLabel.text = "period_date_from".localized()
        dateToLabel.text = "period_date_to".localized()
        chooseButton.setTitle("change_period".localized(), for: .normal)
    }
    
    @IBAction func chooseButtonPressed(_ sender: UIButton) {
        
        delegate?.userChosePeriod(getPeriod())
        navigationController?.popViewController(animated: true)
    }
    
    func getPeriod() -> BalanceManager.BalancePeriod {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let startDate = Formatter.getFormatted(date: datePicker_From.date)
        let endDate = Formatter.getFormatted(date: datePicker_To.date)
        
        CurrentUser.balancePeriod_StartDate = startDate
        CurrentUser.balancePeriod_EndDate = endDate
        
        return BalanceManager.BalancePeriod(startDate: startDate, endDate: endDate)
    }
    
}
