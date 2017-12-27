//
//  Profile.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 27.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import Foundation

struct Profile {
    
    var numberOfItems: Int {
        return items.count
    }
    
    let items: [Item] = [
        Item(title: "Main", segue: "ShowMain", section: 1, iconName: nil),
        Item(title: "My Profile", segue: "ShowProfile", section: 1, iconName: nil),
        Item(title: "Events", segue: "ShowEvents", section: 1, iconName: nil),
        Item(title: "News", segue: "ShowNews", section: 1, iconName: nil),
        Item(title: "Code of ethics", segue: "ShowCodex", section: 1, iconName: nil),
        Item(title: "Members", segue: "ShowMembers", section: 1, iconName: nil),
        Item(title: "Contacts", segue: "ShowContacts", section: 1, iconName: nil),
        Item(title: "Settings", segue: "ShowSettings", section: 1, iconName: nil),
        ]
    
    class ProfileCell {
        let title: String
        let segue: String
        let cellID: String = "MenuCell"
        let section: Int
        let iconName: String?
        var icon: UIImage? {
            return UIImage(named: iconName ?? "")
        }
    }
}
