//
//  AuthManager.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

class AuthManager {
    
    func perform(_ action: AuthAction, completionHandler: @escaping SuccessBehaviour) {
        switch action {
        case .RegisterWith(let regUserData):
            performRequestTo(.registerPage, completionHandler: {
                <#code#>
            })
        case .LoginWith(let logUserData):
            performRequestTo(.registerPage, completionHandler: {
                <#code#>
            })
        }
    }
    
    func performRequestTo(_ address: ActionAddress, completionHandler: @escaping ()->(result: ResultData, error: AuthError) ) {
        
    }
    
    enum AuthError {
        
    }
    
    enum AuthAction {
        case RegisterWith(userData: RegisterUserData)
        case LoginWith(userData: LoginUserData)
    }
    
    struct RegisterUserData {
        let email: String
        let password: String
        let phone: String?
        let name: String?
    }
    
    struct LoginUserData {
        let email: String
        let password: String
    }
    
    struct ResultData {
        let id: String
        let name: String
        let phone: String
        let email: String
        let pass: String
        let rest: String
        let ball: String
        let active: String
    }
    
    enum ActionAddress: String {
        case loginPage = "https://serwer1651270.home.pl/admin/api/login"
        case registerPage = "https://serwer1651270.home.pl/admin/api/register"
    }
}
