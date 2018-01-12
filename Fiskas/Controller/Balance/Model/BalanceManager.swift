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
        actualization: "Pending...",
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
            return String(total)
        }
    }
    
    static func getQuarterOrMonthNameDependsOn(_ index: String) -> String {
        
        let newIndex = String(index.dropFirst(2))

        switch newIndex {
        case "0":
            return "Quarter 1"
        case "0.0":
            return "Month 1"
        case "0.1":
            return "Month 2"
        case "0.2":
            return "Month 3"
        case "1":
            return "Quarter 2"
        case "1.0":
            return "Month 4"
        case "1.1":
            return "Month 5"
        case "1.2":
            return "Month 6"
        case "2":
            return "Quarter 3"
        case "2.0":
            return "Month 7"
        case "2.1":
            return "Month 8"
        case "2.2":
            return "Month 9"
        case "3":
            return "Quarter 4"
        case "3.0":
            return "Month 10"
        case "3.1":
            return "Month 11"
        case "3.2":
            return "Month 12"
        default:
            return "Undefined cell"
        }
    }
    
    func getKJTree() -> KJTree {
        
        var arrayWithParents = [Parent]()
        
        arrayWithParents.append(Parent())
        
        for _ in arrayWithCategories {
            let parent = Parent() { () -> [Child] in
                var arrayWithChildrens = [Child]()
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
