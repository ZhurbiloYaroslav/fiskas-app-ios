//
//  ContactsVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ContactsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func makePhoneCall1(_ sender: UIButton) {
        Browser.openURLWith(.Call_555_549)
    }
    
    @IBAction func sendEmailButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Mail_Kancelaria_Fiskas)
    }
    
}
