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

class Invoice: NSObject {
    
    let baseURL = "https://serwer1651270.home.pl"
    
    var id: String!
    var name: String!
    var date: String!
    var image: UIImage?
    private var imageAddress: String!
    func getImageURL() -> URL? {
        return URL(string: baseURL + imageAddress)
    }
    
    init(id: String, name: String, date: String, imageAddress: String) {
        self.id = id
        self.name = name
        self.date = date
        self.imageAddress = imageAddress
    }
    
    convenience init(withResult resultDictionary: [String: Any]) {
        
        let id = resultDictionary["id"] as? String ?? ""
        let name = resultDictionary["name"] as? String ?? ""
        let date = resultDictionary["date"] as? String ?? ""
        var imageAddress = resultDictionary["image"] as? String ?? ""
        
        imageAddress = imageAddress.replacingOccurrences(of: " ", with: "%20")
        
        self.init(id: id, name: name, date: date, imageAddress: imageAddress)
    }
}
