//
//  CurrentCompany.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 03.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class CurrentCompany {
    
    private static let defaults = UserDefaults.standard
    
}

//MARK: Variables
extension CurrentCompany {
    
    static var name: String {
        get {
            let defaultValue = "Kancelaria Księgowa Fiskas Sp z o. o."
            return defaults.object(forKey: "currentCompanyName") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyName")
            defaults.synchronize()
        }
    }
    static var address: String {
        get {
            let defaultValue = "ul. Legnicka 150/2\n54-206 Wrocław"
            return defaults.object(forKey: "currentCompanyAddress") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyAddress")
            defaults.synchronize()
        }
    }
    static var nip: String {
        get {
            let defaultValue = "8943072632"
            return defaults.object(forKey: "currentCompanyNIP") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyNIP")
            defaults.synchronize()
        }
    }
    static var regon: String {
        get {
            let defaultValue = "363655234"
            return defaults.object(forKey: "currentCompanyRegon") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyRegon")
            defaults.synchronize()
        }
    }
    static var actualization: String {
        get {
            let defaultValue = "6.12.2017 17:44"
            return defaults.object(forKey: "currentCompanyActualization") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyActualization")
            defaults.synchronize()
        }
    }
    static var email: String {
        get {
            let defaultValue = "kancelaria.fiskas@gmail.com"
            return defaults.object(forKey: "currentCompanyEmail") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyEmail")
            defaults.synchronize()
        }
    }
    static var phone: String {
        get {
            let defaultValue = "+48 535 555 549"
            return defaults.object(forKey: "currentCompanyPhone") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyPhone")
            defaults.synchronize()
        }
    }
    static var taxService: String {
        get {
            let defaultValue = "VAT"
            return defaults.object(forKey: "currentCompanyTax") as? String ?? defaultValue
        }
        set {
            defaults.set(newValue, forKey: "currentCompanyTax")
            defaults.synchronize()
        }
    }
    
}

class Bank {
    var name: String!
    var accountNumber: String!
}
