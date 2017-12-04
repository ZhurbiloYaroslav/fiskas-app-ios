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
    
    var firstName: String!
    var lastName: String!
    var email: String!
    var phone: String!
    
    private static let defaults = UserDefaults.standard
//    private static let keychainManager = KeychainSwift()
    
//    static func getAccountName() -> String {
//        if name != "" {
//            return name
//        } else if email != "" {
//            return email
//        } else {
//            return "Anonymous"
//        }
//    }
    
    static func logOut(completionHandler: @escaping SuccessBehaviour) {

    }
    
    static func removeUserDataWhenLogOut() {

    }
}

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
    
//    static var id: String {
//        get {
//            return self.keychainManager.get("currentUserID") ?? ""
//        }
//        set {
//            self.keychainManager.set(newValue, forKey: "currentUserID")
//        }
//    }
    
    static var name: String {
        get {
            return defaults.object(forKey: "currentUserName") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "currentUserName")
            defaults.synchronize()
        }
    }
    
//    static var email: String {
//        get {
//            if let currentUserEmail = defaults.object(forKey: "currentUserEmail") as? String, currentUserEmail != "" {
//                return currentUserEmail
//            } else if let currentUserEmail = keychainManager.get("currentUserEmail"), currentUserEmail != "" {
//                return currentUserEmail
//            } else {
//                return ""
//            }
//        }
//        set {
//            defaults.set(newValue, forKey: "currentUserEmail")
//            defaults.synchronize()
//            keychainManager.set(newValue, forKey: "currentUserEmail")
//        }
//    }
    
//    static var phone: String {
//        get {
//            return self.keychainManager.get("currentUserPhone") ?? "Set the Phone number"
//        }
//        set {
//            keychainManager.set(newValue, forKey: "currentUserPhone")
//        }
//    }
    
//    static var authToken: String {
//        get {
//            return self.keychainManager.get("currentUserAuthenticationToken") ?? ""
//        }
//        set {
//            keychainManager.set(newValue, forKey: "currentUserAuthenticationToken")
//        }
//    }
}
