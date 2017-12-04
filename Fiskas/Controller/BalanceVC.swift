//
//  BalanceVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 02.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class BalanceVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUILabelsWithLocalizedText()
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "balance".localized()
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

}
