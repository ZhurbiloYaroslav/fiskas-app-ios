//
//  BalancePeriodVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

protocol BalancePeriodVcDelegate: class {
    
    func userChosePeriod(_ period:Period)
    
}

class BalancePeriodVC: UIViewController {
    
    weak var delegate: BalancePeriodVcDelegate?

    @IBOutlet weak var datePicker_From: UIDatePicker!
    @IBOutlet weak var datePicker_To: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func chooseButtonPressed(_ sender: UIButton) {
        
        delegate?.userChosePeriod(getPeriod())
        navigationController?.popViewController(animated: true)
    }
    
    func getPeriod() -> Period {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let dateFrom = dateFormatter.string(from: datePicker_From.date)
        let dateTo = dateFormatter.string(from: datePicker_To.date)
        return Period(fromDate: dateFrom, toDate: dateTo)
    }
    
}
