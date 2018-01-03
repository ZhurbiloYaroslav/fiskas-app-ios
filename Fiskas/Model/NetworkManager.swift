//
//  NetworkManager.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let headers: HTTPHeaders = HTTPHeaders()
    
    func registerWith(_ userData: RegisterUserData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = userData.getURL() else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in

            if let errorMessages = self.parseRegistrationResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                CurrentUser.password = userData.password
                completionHandler(nil)
            }
        }
    }
    
    func parseRegistrationResultDataWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        let dictWithRegResult = makeDictionaryFrom(response)
        
        guard let error = dictWithRegResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            guard let userDataDict = dictWithRegResult["user"] as? Dictionary<String, String> else {
                errorMessages.append(AuthError().noConnection)
                return errorMessages
            }
            
            CurrentUser.id = userDataDict["id"] ?? ""
            CurrentUser.getFirstAndLastNameFromString(userDataDict["name"] ?? "")
            CurrentUser.phone = userDataDict["phone"] ?? ""
            CurrentUser.email = userDataDict["email"] ?? ""
            CurrentUser.authToken = userDataDict["pass"] ?? ""
            CurrentUser.isUserActive = userDataDict["active"] == "1" ? true : false
            CurrentUser.isLoggedIn = true
            
            return nil
            
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    func loginWith(_ userData: LoginUserData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = userData.getURL() else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in

            if let errorMessages = self.parseLoginResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                CurrentUser.password = userData.password
                completionHandler(nil)
            }
        }
        
    }
    
    func parseLoginResultDataWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        let dictWithLogResult = makeDictionaryFrom(response)

        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            guard let userDataDict = dictWithLogResult["user"] as? Dictionary<String, String> else {
                errorMessages.append(AuthError().invalidResultData)
                return errorMessages
            }
            CurrentUser.id = userDataDict["id"] ?? ""
            CurrentUser.getFirstAndLastNameFromString(userDataDict["name"] ?? "")
            CurrentUser.phone = userDataDict["phone"] ?? ""
            CurrentUser.email = userDataDict["email"] ?? ""
            CurrentUser.authToken = userDataDict["pass"] ?? ""
            CurrentUser.isUserActive = userDataDict["active"] == "1" ? true : false
            CurrentUser.isLoggedIn = true
            
            return nil
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    func uploadPhoto(_ userData: UploadPhotoData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = userData.getURL() else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in
            print("---response", response)
            if let errorMessages = self.parseUploadPhotoResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    func parseUploadPhotoResultDataWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        let dictWithLogResult = makeDictionaryFrom(response)
        
        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            guard let userDataDict = dictWithLogResult["user"] as? Dictionary<String, String> else {
                errorMessages.append(AuthError().invalidResultData)
                return errorMessages
            }
            
//            CurrentUser.id = userDataDict["id"] ?? ""
//            CurrentUser.getFirstAndLastNameFromString(userDataDict["name"] ?? "")
//            CurrentUser.phone = userDataDict["phone"] ?? ""
//            CurrentUser.email = userDataDict["email"] ?? ""
//            CurrentUser.authToken = userDataDict["pass"] ?? ""
//            CurrentUser.isUserActive = userDataDict["active"] == "1" ? true : false
//            CurrentUser.isLoggedIn = true
            
            return nil
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    func makeDictionaryFrom(_ response: DataResponse<Any>) -> Dictionary<String, Any> {
        guard let resourcesArray = response.result.value as? Dictionary<String, Any> else {
            return Dictionary<String, Any>()
        }
        return resourcesArray
    }
    
    struct RegisterUserData {
        let pageAddress: String = "https://serwer1651270.home.pl/admin/api/register"
        let name: String
        let surname: String
        let phone: String
        let email: String
        let password: String
        
        func getParams() -> Parameters {
            return [
                "name": name,
                "surname": surname,
                "email": email,
                "pass": password,
                "phone": phone
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
    struct LoginUserData {
        let pageAddress: String = "https://serwer1651270.home.pl/admin/api/login"
        let email: String
        let password: String
        
        func getParams() -> Parameters {
            return [
                "email": email,
                "pass": password
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
    struct UploadPhotoData {
        let pageAddress: String = "https://serwer1651270.home.pl/admin/api/upload"
        let email: String
        let password: String
        let photoTitle: String
        let photoBody: String
        
        func getParams() -> Parameters {
            return [
                "email": email,
                "pass": password,
                "photo": photoTitle,
                "body": photoBody
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
    struct AuthError {
        let noConnection = "Network Error, check your connection"
        let invalidResultData = "Data Error, check your data"
        let undefined = "Undefined Error"
        let wrongEmailOrPassword = "Email or password are wrong"
    }
}
