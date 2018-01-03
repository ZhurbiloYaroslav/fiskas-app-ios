//
//  PrivacyPolicyVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 03.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class PrivacyPolicyVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUILabelsWithLocalizedText()
    }
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "privacy_policy".localized()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let cell = UITableViewCell()

        // Configure the cell...

        return cell
    }

}
