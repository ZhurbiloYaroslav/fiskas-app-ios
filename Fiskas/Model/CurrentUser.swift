//
//  CurrentUser.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 03.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
//import KeychainSwift

class CurrentUser {
    
    private static let defaults = UserDefaults.standard
    
    static func logOut(completionHandler: @escaping SuccessBehaviour) {
        resetUserDataWhenLogOut()
        completionHandler()
    }
    
    static func getFirstAndLastNameFromString(_ name: String) {
        firstName = ""
        lastName = ""
        
        let arrayFromName = name.components(separatedBy: CharacterSet.whitespaces)
        if arrayFromName.count == 1 {
            firstName = arrayFromName[0]
        } else if arrayFromName.count > 1 {
            firstName = arrayFromName[0]
            for partOfName in arrayFromName[1...(arrayFromName.count - 1)] {
                lastName += partOfName + " "
            }
        }
    }
    
    static func resetUserDataWhenLogOut() {
        isLoggedIn = false
        isUserActive = false
        id = ""
        firstName = ""
        lastName = ""
        email = ""
        password = ""
        phone = ""
        authToken = ""
    }
}

//MARK: Current User Variables
extension CurrentUser {
    
    static var isLoggedIn: Bool {
        get {
            return defaults.object(forKey: "currentUserIsLoggedIn") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "currentUserIsLoggedIn")
            defaults.synchronize()
        }
    }
    
    static var isUserActive: Bool {
        get {
            return defaults.object(forKey: "currentUserIsActive") as? Bool ?? false
        }
        set {
            defaults.set(newValue, forKey: "currentUserIsActive")
            defaults.synchronize()
        }
    }
    
    static var id: String {
        get {
            return defaults.object(forKey: "currentUserID") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserID")
            defaults.synchronize()
        }
    }
    
    static var fullName: String {
        var fullName = ""
        if firstName != "" {
            fullName = firstName
        }
        if firstName != "" && lastName != "" {
            fullName = fullName + " "
        }
        if lastName != "" {
            fullName = fullName + lastName
        }
        return fullName
    }
    
    static var firstName: String {
        get {
            return defaults.object(forKey: "currentUserFirstName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserFirstName")
            defaults.synchronize()
        }
    }
    
    static var lastName: String {
        get {
            return defaults.object(forKey: "currentUserLastName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserLastName")
            defaults.synchronize()
        }
    }
    
    static var email: String {
        get {
            return defaults.object(forKey: "currentUserEmail") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserEmail")
            defaults.synchronize()
        }
    }
    
    static var password: String {
        get {
            return defaults.object(forKey: "currentUserPassword") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserPassword")
            defaults.synchronize()
        }
    }
    
    static var phone: String {
        get {
            return defaults.object(forKey: "currentUserPhone") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserPhone")
            defaults.synchronize()
        }
    }
    
    static var authToken: String {
        get {
            return defaults.object(forKey: "currentUserAuthenticationToken") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserAuthenticationToken")
            defaults.synchronize()
        }
    }
    
    static var balancePeriod_StartDate: String {
        get {
            return defaults.object(forKey: "currentUserBalancePeriod_StartDate") as? String ?? "01.01.2018"
        }
        set {
            defaults.set(newValue, forKey: "currentUserBalancePeriod_StartDate")
            defaults.synchronize()
        }
    }
    
    static var balancePeriod_EndDate: String {
        get {
            return defaults.object(forKey: "currentUserBalancePeriod_EndDate") as? String ?? "01.02.2018"
        }
        set {
            defaults.set(newValue, forKey: "currentUserBalancePeriod_EndDate")
            defaults.synchronize()
        }
    }
}
