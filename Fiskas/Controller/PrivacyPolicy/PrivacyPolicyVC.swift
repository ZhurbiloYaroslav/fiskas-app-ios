//
//  PrivacyPolicyVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 04.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    let showWebVersion = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://soft4status.com/fiskas-privacy-policy/"), showWebVersion {
            
            let requestObj = URLRequest(url: url)
            webView.loadRequest(requestObj)
            
        } else if let localfilePath = Bundle.main.url(forResource: "PrivacyPolicy", withExtension: "html") {
            
            let requestObj = URLRequest(url: localfilePath)
            webView.loadRequest(requestObj)
            
        }
        
    }

}
