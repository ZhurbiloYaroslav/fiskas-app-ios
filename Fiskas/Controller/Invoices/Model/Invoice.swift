//
//  Invoice.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 11.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Invoice {
    
    var name: String!
    var date: String!
    var image: UIImage?
    var imageAddress: String!
    
    init(name: String, date: String, imageAddress: String) {
        self.name = name
        self.date = date
        self.imageAddress = imageAddress
    }
    
    convenience init(withResponse response: DataResponse<Any>) {
        guard let invoiceArray = response.result.value as? (Dictionary<String, Any>)  else {
            self.init(name: "Error", date: "Error", imageAddress: "Error")
            return
        }
        
        self.init(name: "", date: "", imageAddress: "")
    }
}
