//
//  Balance.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 19.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import KJExpandableTableTree

struct BalanceManager {
    
    static var shared = BalanceManager(
        total: Total(buy: 0, sell: 0, income: 0),
        actualization: "balance_actualization_pending".localized(),
        arrayWithCategories: [Category]()
    )
    
    var total: Total
    var actualization: String
    var arrayWithCategories: [Category] = [Category]()
    
    struct Total {
        var buy: Double
        var sell: Double
        var income: Double
    }
    
    struct BalancePeriod {
        var startDate: String
        var endDate: String
        
        func getPeriod() -> String {
            return startDate + " - " + endDate
        }
        
        init(startDate: String, endDate: String) {
            self.startDate = startDate
            self.endDate = endDate
        }
        
        init() {
            self.init(startDate: "01.01.2018", endDate: "01.02.2018")
        }
    }
    
    struct Category {
        let name: String!
        var arrayWithmonths: [Double]!
        
        init(name: String, dictWithmonths: [String: Double]) {
            self.name = name
            
            arrayWithmonths = [Double]()
            for index in ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"] {
                arrayWithmonths.append(dictWithmonths[index] ?? 0)
            }
        }
        
        func getStringWithTotalValue() -> String {
            var total: Double = 0
            for monthValue in arrayWithmonths {
                total += monthValue
            }
            return String(total) + " " + Constants.currency
        }
    }
    
    static func getQuarterOrMonthNameDependsOn(_ index: String) -> String {
        
        let newIndex = String(index.dropFirst(2))
        
        switch newIndex {
        case "0":
            return "balance_table_quarter_1".localized()
        case "0.0":
            return "balance_table_month_1".localized()
        case "0.1":
            return "balance_table_month_2".localized()
        case "0.2":
            return "balance_table_month_3".localized()
        case "1":
            return "balance_table_quarter_2".localized()
        case "1.0":
            return "balance_table_month_4".localized()
        case "1.1":
            return "balance_table_month_5".localized()
        case "1.2":
            return "balance_table_month_6".localized()
        case "2":
            return "balance_table_quarter_3".localized()
        case "2.0":
            return "balance_table_month_7".localized()
        case "2.1":
            return "balance_table_month_8".localized()
        case "2.2":
            return "balance_table_month_9".localized()
        case "3":
            return "balance_table_quarter_4".localized()
        case "3.0":
            return "balance_table_month_10".localized()
        case "3.1":
            return "balance_table_month_11".localized()
        case "3.2":
            return "balance_table_month_12".localized()
        default:
            return "balance_table_undefined_cell".localized()
        }
    }
    
    static func getCellValueDependsOn(_ index: String) -> Double {
        
        // Get months of current category cell
        let arrayWithIndices = index.components(separatedBy: ".")
        let categoryIndex = (Int(arrayWithIndices[0]) ?? 1) - 1
        guard let categoryMonths = BalanceManager.shared.arrayWithCategories[categoryIndex].arrayWithmonths
            else { return 0 }
        
        // Get value of current cell
        let newIndex = String(index.dropFirst(2))
        switch newIndex {
        // Quarter 1
        case "0": // Total of quarter 1
            return categoryMonths[0] + categoryMonths[1] + categoryMonths[2]
        case "0.0":  // Value of month 1
            return categoryMonths[0]
        case "0.1":  // Value of month 2
            return categoryMonths[1]
        case "0.2":  // Value of month 3
            return categoryMonths[2]
            
        // Quarter 2
        case "1": // Total of quarter 2
            return categoryMonths[3] + categoryMonths[4] + categoryMonths[5]
        case "1.0":  // Value of month 4
            return categoryMonths[3]
        case "1.1":  // Value of month 5
            return categoryMonths[4]
        case "1.2":  // Value of month 6
            return categoryMonths[5]
            
        // Quarter 3
        case "2": // Total of quarter 3
            return categoryMonths[6] + categoryMonths[7] + categoryMonths[8]
        case "2.0":  // Value of month 7
            return categoryMonths[6]
        case "2.1":  // Value of month 8
            return categoryMonths[7]
        case "2.2":  // Value of month 9
            return categoryMonths[8]
            
        // Quarter 4
        case "3": // Total of quarter 4
            return categoryMonths[9] + categoryMonths[10] + categoryMonths[11]
        case "3.0":  // Value of month 10
            return categoryMonths[9]
        case "3.1":  // Value of month 11
            return categoryMonths[10]
        case "3.2":  // Value of month 12
            return categoryMonths[11]
            
        default:
            return 0
        }
    }
    
    func getKJTree() -> KJTree {
        
        var arrayWithParents = [Parent]()
        
        arrayWithParents.append(Parent())
        
        for _ in arrayWithCategories {
            let parent = Parent() { () -> [Child] in
                //var arrayWithChildrens = [Child]()
                let child1 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child()
                    let subchild3 = Child()
                    return [subchild1, subchild2, subchild3]
                })
                
                let child2 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child()
                    let subchild3 = Child()
                    return [subchild1, subchild2, subchild3]
                })
                
                let child3 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child()
                    let subchild3 = Child()
                    return [subchild1, subchild2, subchild3]
                })
                
                let child4 = Child(subChilds: { () -> [Child] in
                    let subchild1 = Child()
                    let subchild2 = Child()
                    let subchild3 = Child()
                    return [subchild1, subchild2, subchild3]
                })
                
                return [child1, child2, child3, child4]
            }
            arrayWithParents.append(parent)
        }
        
        arrayWithParents.append(Parent())
        
        return KJTree(Parents: arrayWithParents)
    }
    
    func getArrayWithChildrensWithAmount(_ amount: Int) -> [Child] {
        var arrayWithChildren = [Child]()
        for _ in 1...amount {
            arrayWithChildren.append(Child())
        }
        return arrayWithChildren
    }
}
