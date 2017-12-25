//
//  MenuVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 04.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import MessageUI

class MenuVC: UITableViewController {
    
    var emailForLoginVC: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            performSegue(withIdentifier: "ShowInvoiceFromMenu", sender: nil)
        case [0,3]:
            performSegue(withIdentifier: "ShowContactsFromMenu", sender: nil)
        case [0,4]:
            performSegue(withIdentifier: "ShowProfileFromMenu", sender: nil)
        case [0,5]:
            sendReportAboutProblem()
        case [0,6]:
            logOutFromAccount()
        default:
            print("selected undefined cell in menu")
            break
        }
    }
    
    func logOutFromAccount() {
        emailForLoginVC = CurrentUser.email

        CurrentUser.logOut(completionHandler: {
            self.performSegue(withIdentifier: "ShowLoginVC", sender: nil)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueID = segue.identifier else { return }
        
        switch segueID {
        case "ShowLoginVC":
            if let destination = segue.destination as? LoginVC {
                destination.emailFromRegistration = emailForLoginVC
            }
        default:
            print("Was performed Undefined segue")
        }
    }
    
    func sendReportAboutProblem() {
        let mailComposeViewController = configuredMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }

}


extension MenuVC: MFMailComposeViewControllerDelegate {
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        let recipients = ["kancelaria.fiskas@gmail.com"]
        mailComposerVC.setToRecipients(recipients)
        let emailSubject = "report_a_problem_subject".localized()
        mailComposerVC.setSubject(emailSubject)
        
        let emailMessage = "report_a_problem_message".localized()
        mailComposerVC.setMessageBody(emailMessage, isHTML: false)
        
        return mailComposerVC
        
    }
    
    
    func showSendMailErrorAlert() {
        
        let alertTitle = "could_not_send_email".localized()
        let alertMessage = "Your device could not send e-mail. Please check e-mail configuration and try again".localized()
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okActionTitle = "OK".localized()
        let okAction = UIAlertAction(title: okActionTitle, style: .default, handler: nil)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        
    }
    
}
