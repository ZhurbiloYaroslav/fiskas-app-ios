//
//  TabBarVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUILabelsWithLocalizedText()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        updateUILabelsWithLocalizedText()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {
        
        tabBar.items?[0].title = "balance".localized()
        tabBar.items?[1].title = "make photo".localized()
        tabBar.items?[2].title = "contacts".localized()
        tabBar.items?[3].title = "profile".localized()
        
    }

}
