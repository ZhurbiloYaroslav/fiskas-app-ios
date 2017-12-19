//
//  Balance.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

struct Balance {
    
    var items: [Category] = [
        Balance.Category(name: "balance_cash".localized()),
        Balance.Category(name: "balance_state_bank".localized()),
        Balance.Category(name: "balance_debts".localized()),
        Balance.Category(name: "balance_liability".localized())
    ]
    
    struct Category {
        let name: String
        func getStringWithTotalValue() -> String {
            return "100$"
        }
    }
}
