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
    static let baseURL = "https://serwer1651270.home.pl/admin/api/"
    
    struct AuthError {
        let noConnection = "Network Error, check your connection"
        let invalidResultData = "Data Error, check your data"
        let undefined = "Undefined Error"
        let wrongEmailOrPassword = "Email or password are wrong"
    }
}

//MARK: Login
extension NetworkManager {
    
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
    
    struct LoginUserData {
        let pageAddress: String = NetworkManager.baseURL + "login"
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
    
}

//MARK: Register
extension NetworkManager {
    
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
    
    struct RegisterUserData {
        let pageAddress: String = baseURL + "register"
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
}

//MARK: Balance
extension NetworkManager {
    
    func getBalanceFor(_ balanceData: RequestBalanceData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = balanceData.getURL() else { return }
        
        let parameters = balanceData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in
            print("---balance response: ", response)
            if let errorMessages = self.parseBalanceResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    func parseBalanceResultDataWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        let dictWithLogResult = makeDictionaryFrom(response)
        
        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            guard let userDataDict = dictWithLogResult["report"] as? Dictionary<String, String> else {
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
    
    struct RequestBalanceData {
        let pageAddress: String = NetworkManager.baseURL + "report"
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
    
}

//MARK: Photo
extension NetworkManager {
    
    func uploadPhoto(_ userData: UploadPhotoData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        let image = userData.photoBody
        guard let imgData = UIImageJPEGRepresentation(image, 1) else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image",fileName: "\(userData.photoTitle).jpg", mimeType: "image/jpg")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: userData.pageAddress) { result in
            switch result {
                
            case .success(_, _, _): // case .success(let upload, _, _):
                completionHandler(nil)
                // upload.responseJSON { response in
                //     if let errorMessages = self.parseUploadPhotoResultDataWith(response) {
                //         completionHandler(errorMessages)
                //     } else {
                //         completionHandler(nil)
                //     }
            // }
            case .failure(let encodingError):
                completionHandler([encodingError.localizedDescription])
            }
        }
    }
    
    func makeDictionaryFrom(_ response: DataResponse<Any>) -> Dictionary<String, Any> {
        guard let resourcesArray = response.result.value as? Dictionary<String, Any> else {
            return Dictionary<String, Any>()
        }
        return resourcesArray
    }
    
    struct UploadPhotoData {
        let pageAddress: String = NetworkManager.baseURL + "upload"
        let email: String
        let password: String
        let photoTitle: String
        let photoBody: UIImage
        
        func getParams() -> Parameters {
            return [
                "email": email,
                "pass": password,
                "name": photoTitle
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
}
