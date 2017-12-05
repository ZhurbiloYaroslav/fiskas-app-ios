//
//  MenuVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 04.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.updateCellWith(indexPath: indexPath)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            performSegue(withIdentifier: "ShowBalanceFromMenu", sender: nil)
        case [0,1]:
            performSegue(withIdentifier: "ShowCameraFromMenu", sender: nil)
        case [0,2]:
            performSegue(withIdentifier: "ShowContactsFromMenu", sender: nil)
        case [0,3]:
            performSegue(withIdentifier: "ShowProfileFromMenu", sender: nil)
        default:
            print("selected undefined cell in menu")
            break
        }
    }

}
