//
//  CurrentCompany.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 03.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class CurrentCompany {
    var name: String!
    var nip: String!
    var regon: String!
    var bank: Bank!
    var email: String!
}

class Bank {
    var name: String!
    var accountNumber: String!
}
