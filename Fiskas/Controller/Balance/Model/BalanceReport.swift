//
//  BalanceReport.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 08.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class BalanceReport {
    
//    var balance: Balance
//    var period: BalancePeriod
//    var arrayWithCategories: [BalanceCategory]
//
//    init(period: BalancePeriod, balance: Balance, arrayWithCategories: [BalanceCategory]) {
//        self.period = period
//        self.balance = balance
//        self.arrayWithCategories = arrayWithCategories
//    }
    
//    static func createArrayWithCategories(arrayWithValues: [String: String]) -> [BalanceCategory] {
//        var tempArrayWithValues = [BalanceCategory]()
//        for dictWithValues in arrayWithValues {
//            print("---addBalanceCategory: ", dictWithValues)
//        }
//    }
}

//MARK: Additional Structures
extension BalanceReport {
    
    struct BalancePeriod {
        var startDate: String = "01.01.2017"
        var endDate: String = "31.12.2017"
        
        init(startDate: String, endDate: String) {
            self.startDate = startDate
            self.endDate = endDate
        }
    }
    
    struct BalanceCategory {
        let name: String
        var arrayWithMonts: [BalanceMonth]
        
        init(name: String, arrayWithmonths: [String: String]) {
            self.name = name
            
            self.arrayWithMonts = [BalanceMonth]()
            for monthValue in arrayWithmonths {
                print("---addMonthValue: ", monthValue)
            }
        }
        
        struct BalanceMonth {
            var value: Double
            
            init(value: String) {
                self.value = Double(value) ?? 0
            }
        }
    }
}
