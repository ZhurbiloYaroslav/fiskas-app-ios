//
//  CurrentCompany.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 03.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class CurrentCompany {
    
}

//MARK: Variables
extension CurrentCompany {
    
    static var name: String {
        return "Kancelaria Księgowa Fiskas Sp z o. o."
    }
    static var address: String {
        return """
        ul. Legnicka 150/2
        54-206 Wrocław
        """
    }
    static var nip: String {
        return "8943072632"
    }
    static var regon: String {
        return "363655234"
    }
    static var actualization: String {
        return "6.12.2017 17:44"
    }
    static var email: String {
        return "kancelaria.fiskas@gmail.com"
    }
    static var phone: String {
        return "+48 535 555 549"
    }
    static var taxService: String {
        return "VAT"
    }
    
}

class Bank {
    var name: String!
    var accountNumber: String!
}
