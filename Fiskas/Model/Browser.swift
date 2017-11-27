//
//  Browser.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Foundation

class Browser {
    
    static func openURLWith(_ urlAddress: UrlAdresses) {
        
        if let url = URL(string: urlAddress.rawValue), UIApplication.shared.canOpenURL(url){
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        } else {
            print("can't open")
        }
    }
    enum UrlAdresses: String {
        case Call_555_549 = "tel://+48535555549"
        case Mail_Kancelaria_Fiskas = "mailto:kancelaria.fiskas@gmail.com"
    }
}
