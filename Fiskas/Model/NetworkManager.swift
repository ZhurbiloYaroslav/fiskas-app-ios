//
//  NetworkManager.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import Alamofire

@objc protocol NetworkManagerDelegate {
    @objc optional func didLoad(arrayWithInvoices:[Invoice])
}

class NetworkManager: NSObject {
    
    weak var delegate: NetworkManagerDelegate?
    
    private var arrayWithInvoices: [Invoice]!
    
    let headers: HTTPHeaders = HTTPHeaders()
    static let baseURL = "https://serwer1651270.home.pl/admin/api/"
    
    struct AuthError {
        let noConnection = "Network Error, check your connection"
        let invalidResultData = "Data Error, check your data"
        let undefined = "Undefined Error"
        let wrongEmailOrPassword = "Email or password are wrong"
        let recoveryOK = "Password was sent to your Email"
        let updateOK = "Values have been updated on server"
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
            CurrentUser.firstName = userDataDict["name"] ?? ""
            CurrentUser.lastName = userDataDict["surname"] ?? ""
            CurrentUser.phone = userDataDict["phone"] ?? ""
            CurrentUser.email = userDataDict["email"] ?? ""
            CurrentUser.isUserActive = userDataDict["active"] == "1" ? true : false
            CurrentUser.isLoggedIn = true
            
            CurrentCompany.name = userDataDict["company_name"] ?? ""
            CurrentCompany.address = userDataDict["address"] ?? ""
            CurrentCompany.nip = userDataDict["tax_code"] ?? ""
            CurrentCompany.regon = userDataDict["company_tax_code"] ?? ""
            CurrentCompany.taxService = userDataDict["tax_type"] ?? ""
            CurrentCompany.phone = userDataDict["company_phone"] ?? ""
            CurrentCompany.email = userDataDict["company_email"] ?? ""
            
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
        let email: String
        let password: String
        let firstName: String
        let lastName: String
        let phone: String
        let companyName: String
        let companyAddress: String
        let nip: String
        let regon: String
        let taxType: String
        let companyEmail: String
        let companyPhone: String
        
        func getParams() -> Parameters {
            return [
                "email": email,
                "pass": password,
                "name": firstName,
                "surname": lastName,
                "phone": phone,
                "company_name": companyName,
                "address": companyAddress,
                "taxcode": nip,
                "company_tax_code": regon,
                "tax_type": taxType,
                "company_email": companyEmail,
                "company_phone": companyPhone
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
}

//MARK: Update values
extension NetworkManager {
    
    func updateValues(completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        let userData = UpdateUserData()
        guard let url = userData.getURL() else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in
            
            if let errorMessages = self.parseUpdateResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    func parseUpdateResultDataWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        let dictWithLogResult = makeDictionaryFrom(response)
        
        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            errorMessages.append(AuthError().updateOK)
            return errorMessages
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    struct UpdateUserData {
        let pageAddress: String = NetworkManager.baseURL + "update"
        
        func getParams() -> Parameters {
            return [
                "id": CurrentUser.id,
                "email": CurrentUser.email,
                "pass": CurrentUser.password,
                "name": CurrentUser.firstName,
                "surname": CurrentUser.lastName,
                "phone": CurrentUser.phone,
                "company_name": CurrentCompany.name,
                "address": CurrentCompany.address,
                "taxcode": CurrentCompany.nip,
                "company_tax_code": CurrentCompany.regon,
                "tax_type": CurrentCompany.taxService,
                "company_phone": CurrentCompany.phone,
                "company_email": CurrentCompany.email
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
            guard let userDataDict = dictWithLogResult["report"] as? Dictionary<String, Any> else {
                errorMessages.append(AuthError().invalidResultData)
                return errorMessages
            }
            
            guard let actualization = userDataDict["date"] as? String else { return nil }
            BalanceManager.shared.actualization = actualization
            
            guard let balance = userDataDict["balance"] as? Dictionary<String, Double> else { return nil }
            BalanceManager.shared.total = BalanceManager.Total(
                buy: balance["buy"] ?? 0,
                sell: balance["sale"] ?? 0,
                income: balance["income"] ?? 0
            )
            
            BalanceManager.shared.arrayWithCategories = [BalanceManager.Category]()
            guard let dictWithCategories = userDataDict["table"] as? Dictionary<String, [String: Double]> else { return nil }
            
            let arrayOfCategoryNamesWithProperOrder = ["nal", "ost", "dolg", "tax"]
            for categoryName in arrayOfCategoryNamesWithProperOrder {
                let newCategory = BalanceManager.Category(
                    name: categoryName,
                    dictWithmonths: dictWithCategories[categoryName] ?? [String: Double]()
                )
                BalanceManager.shared.arrayWithCategories.append(newCategory)
            }
            
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
                "pass": password,
                "startDate": CurrentUser.balancePeriod_StartDate,
                "endDate": CurrentUser.balancePeriod_EndDate
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
}

//MARK: Invoices
extension NetworkManager {
    
    func getInvoicesFor(_ invoiceData: RequestInvoiceData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = invoiceData.getURL() else { return }
        
        let parameters = invoiceData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in
            
            if let errorMessages = self.parseInvoicesWith(response) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    private func parseInvoicesWith(_ response: DataResponse<Any>) -> [String]? {
        
        var errorMessages = [String]()
        arrayWithInvoices = [Invoice]()
        let dictWithLogResult = makeDictionaryFrom(response)
        
        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            guard let arrayWithInvoicesResult = dictWithLogResult["factures"] as? [Dictionary<String, String>] else {
                errorMessages.append(AuthError().invalidResultData)
                return errorMessages
            }
            
            for dictWithResult in arrayWithInvoicesResult {
                let invoice = Invoice(withResult: dictWithResult)
                arrayWithInvoices.append(invoice)
            }
            
            delegate?.didLoad?(arrayWithInvoices: arrayWithInvoices)
            return nil
            
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    struct RequestInvoiceData {
        let pageAddress: String = NetworkManager.baseURL + "factures"
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
        let uuid = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        let fileName = "\(uuid).jpg"
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "image",fileName: fileName, mimeType: "image/jpg")
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

//MARK: Recover password
extension NetworkManager {
    
    func recoveryUserPassword(_ userData: RecoveryUserData, completionHandler: @escaping (_ errorMessages: [String]?)->()) {
        
        guard let url = userData.getURL() else { return }
        
        let parameters = userData.getParams()
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { (response) in
            
            if let errorMessages = self.parseRecoveryUserPasswordResultDataWith(response) {
                completionHandler(errorMessages)
            } else {
                completionHandler(nil)
            }
        }
        
    }
    
    func parseRecoveryUserPasswordResultDataWith(_ response: DataResponse<Any>) -> [String]? {

        var errorMessages = [String]()
        let dictWithLogResult = makeDictionaryFrom(response)
        
        guard let error = dictWithLogResult["res"] as? Int else {
            errorMessages.append(AuthError().noConnection)
            return errorMessages
        }
        
        switch error {
        case 0:
            errorMessages.append(AuthError().recoveryOK)
            return errorMessages
        case 1:
            errorMessages.append(AuthError().wrongEmailOrPassword)
            return errorMessages
        default:
            errorMessages.append(AuthError().undefined)
            return errorMessages
        }
    }
    
    struct RecoveryUserData {
        let pageAddress: String = NetworkManager.baseURL + "recovery"
        let email: String
        
        func getParams() -> Parameters {
            return [
                "email": email
            ]
        }
        
        func getURL() -> URL? {
            var result = "\(pageAddress)"
            result = result.replacingOccurrences(of: " ", with: "%20")
            return URL(string: result)
        }
    }
    
}
