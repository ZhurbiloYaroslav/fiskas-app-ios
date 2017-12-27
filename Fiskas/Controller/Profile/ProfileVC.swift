//
//  ProfileVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController

class ProfileVC: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Personal Data
    @IBOutlet weak var firstNameHeaderLabel: UILabel!
    @IBOutlet weak var firstNameTextButton: UIButton!
    
    @IBOutlet weak var lastNameHeaderLabel: UILabel!
    @IBOutlet weak var lastNameTextButton: UIButton!
    
    @IBOutlet weak var emailHeaderLabel: UILabel!
    @IBOutlet weak var userEmailTextLabel: UILabel!
    
    @IBOutlet weak var phoneHeaderLabel: UILabel!
    @IBOutlet weak var userPhoneTextLabel: UILabel!
    
    
    // Company Info
    @IBOutlet weak var companyNameHeaderLabel: UILabel!
    @IBOutlet weak var companyName_ValueLabel: UILabel!
    
    @IBOutlet weak var companyAddressHeaderLabel: UILabel!
    @IBOutlet weak var companyAddress_ValueLabel: UILabel!
    
    @IBOutlet weak var nipHeaderLabel: UILabel!
    @IBOutlet weak var nip_ValueLabel: UILabel!
    
    @IBOutlet weak var regonHeaderLabel: UILabel!
    @IBOutlet weak var regon_ValueLabel: UILabel!
    
    @IBOutlet weak var companyEmailHeaderLabel: UILabel!
    @IBOutlet weak var companyEmail_ValueLabel: UILabel!
    
    @IBOutlet weak var companyPhoneHeaderLabel: UILabel!
    @IBOutlet weak var companyPhone_ValueLabel: UILabel!
    
    @IBOutlet weak var taxServiceHeaderLabel: UILabel!
    @IBOutlet weak var taxService_ValueLabel: UILabel!
    
    
    // Settings
    @IBOutlet weak var passwordHeaderLabel: UILabel!
    @IBOutlet weak var passwordTextLabel: UILabel!
    
    @IBOutlet weak var pushNotificationsHeaderLabel: UILabel!
    @IBOutlet weak var privacyPolicyHeaderLabel: UILabel!
    @IBOutlet weak var deleteAccountLabel: UILabel!
    
    var emailForLoginVC: String?
    
    var currentAlertVC: UIAlertController!
    var textFieldTypeInCurrentAlertVC: ProfileField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLeftMenu()
        updateUILabelsWithLocalizedText()
        updateLabelsWithUserInfo()
        
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "profile".localized()
        
        // Personal Data
        firstNameHeaderLabel.text = "first_name".localized()
        lastNameHeaderLabel.text = "last_name".localized()
        emailHeaderLabel.text = "email".localized()
        phoneHeaderLabel.text = "phone".localized()
        
        // Company Info
        companyNameHeaderLabel.text = "company_name".localized()
        companyAddressHeaderLabel.text = "company_address".localized()
        nipHeaderLabel.text = "nip".localized()
        regonHeaderLabel.text = "regon".localized()
        companyEmailHeaderLabel.text = "email".localized()
        companyPhoneHeaderLabel.text = "phone".localized()
        taxServiceHeaderLabel.text = "tax_service".localized()
        
        // Settings
        passwordHeaderLabel.text = "password".localized()
        passwordTextLabel.text = "change_password".localized()
        
        pushNotificationsHeaderLabel.text = "push_notifications".localized()
        privacyPolicyHeaderLabel.text = "privacy_policy".localized()
        deleteAccountLabel.text = "delete_account".localized()
        
    }
    
    func updateLabelsWithUserInfo() {
        firstNameTextButton.setTitle(CurrentUser.firstName, for: .normal)
        lastNameTextButton.setTitle(CurrentUser.lastName, for: .normal)
        userEmailTextLabel.text = CurrentUser.email
        userPhoneTextLabel.text = CurrentUser.phone
        
        companyName_ValueLabel.text = CurrentCompany.name
        companyAddress_ValueLabel.text = CurrentCompany.address
        nip_ValueLabel.text = CurrentCompany.nip
        regon_ValueLabel.text = CurrentCompany.regon
        companyEmail_ValueLabel.text = CurrentCompany.email
        companyPhone_ValueLabel.text = CurrentCompany.phone
        taxService_ValueLabel.text = CurrentCompany.taxService
    }
    
    func setupLeftMenu() {
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 7
        case 2:
            return 4
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerTitleText = ""
        
        switch section {
        case 0:
            headerTitleText = "personal_info".localized()
        case 1:
            headerTitleText = "company_info".localized()
        case 2:
            headerTitleText = "options".localized()
        default:
            break
        }
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        headerView.backgroundColor = Constants.Color.red
        
        let headerTitleLabel = UILabel(frame: CGRect(x: 15, y: 3, width: tableView.frame.size.width, height: 30))
        headerTitleLabel.text = headerTitleText
        headerTitleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 18)
        headerTitleLabel.textColor = UIColor.white
        headerView.addSubview(headerTitleLabel)
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    @IBAction func firstNameButtonPressed(_ sender: UIButton) {
        showAlertToChange(field: .FirstName)
    }
    
    @IBAction func lastNameButtonPressed(_ sender: UIButton) {
        showAlertToChange(field: .LastName)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,1]:
            showAlertToChange(field: .Email)
        case [0,2]:
            showAlertToChange(field: .Phone)
        case [2,3]:
            showAlertToChange(field: .LogOut)
        default:
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
    
    enum ProfileField {
        case FirstName
        case LastName
        case Email
        case Password
        case Phone
        case LogOut
    }

}

extension ProfileVC {
    
    func showAlertToChange(field: ProfileField) {
        
        let alertTitle = "Change profile"
        let alertMessage = "Change field"
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let alertActionOk = UIAlertAction(title: "OK", style: .default) { [weak alertController] (_) in
            self.saveUserInfoFromAlertTextField(alertController, field: field)
        }
        
        alertController.addAction(alertActionCancel)
        
        switch field {
        case .FirstName:
            alertController.title = "Change First name"
            alertController.message = "\(alertMessage): First name" + ""
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .FirstName)
            alertController.addAction(alertActionOk)
        case .LastName:
            alertController.title = "Change Last name"
            alertController.message = "\(alertMessage): Last name" + ""
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .LastName)
            alertController.addAction(alertActionOk)
        case .Email:
            alertController.title = "Change Email"
            alertController.message = "\(alertMessage): Email" + ""
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Email)
            alertController.addAction(alertActionOk)
        case .Password:
            alertController.title = "Change Password"
            alertController.message = "\(alertMessage): Password" + ""
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Password)
            alertController.addAction(alertActionOk)
        case .Phone:
            alertController.title = "Change Phone"
            alertController.message = "\(alertMessage): Phone" + ""
            makeFirstTextFieldForAlertController(alertVC: alertController, field: .Phone)
            alertController.addAction(alertActionOk)
        case .LogOut:
            alertController.title = "Log out"
            alertController.message = "Do you really want log out?"
            alertController.addAction(UIAlertAction(title: "Log out", style: .destructive, handler: { (alertAction) in
                self.logOutFromAccount()
            }))
        }
        
        present(alertController, animated: true)
    }
    
    func saveUserInfoFromAlertTextField(_ alertController: UIAlertController?, field: ProfileField) {
        if let alertFieldText = alertController?.textFields?[0].text {
            switch field {
            case .FirstName:
                CurrentUser.firstName = alertFieldText
            case .LastName:
                CurrentUser.lastName = alertFieldText
            case .Email:
                CurrentUser.email = alertFieldText
            case .Phone:
                CurrentUser.phone = alertFieldText
            default:
                print("Undefined 456")
            }
        }
        self.updateLabelsWithUserInfo()
        self.tableView.reloadData()
    }
    
    func makeFirstTextFieldForAlertController(alertVC: UIAlertController, field: ProfileField) {
        
        currentAlertVC = alertVC
        textFieldTypeInCurrentAlertVC = field
        
        alertVC.addTextField { (textField) in
            switch field {
            case .FirstName:
                textField.text = CurrentUser.firstName
                textField.placeholder = "First name"
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .LastName:
                textField.text = CurrentUser.lastName
                textField.placeholder = "Last name"
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .Email:
                textField.text = CurrentUser.email
                textField.placeholder = "Email"
                textField.keyboardType = UIKeyboardType.emailAddress
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .Password:
                textField.text = ""
                textField.placeholder = "Password"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .Phone:
                textField.placeholder = "Phone"
                textField.text = CurrentUser.phone
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .LogOut:
                return
            }
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let fieldText = textField.text else { return }
        var newMessage = ""
        var attributes = [ NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        switch textFieldTypeInCurrentAlertVC {
            
        case .Email:
            if Validator.isEmailValid(fieldText) {
                currentAlertVC.actions[1].isEnabled = true
                newMessage = "Your email is okay"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                currentAlertVC.actions[1].isEnabled = false
                newMessage = "Your email is invalid"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        case .Password:
            if Validator.isPasswordValid(fieldText) {
                currentAlertVC.actions[1].isEnabled = true
                newMessage = "Your password is okay"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                currentAlertVC.actions[1].isEnabled = false
                newMessage = "Your password is invalid"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        case .Phone:
            if Validator.isPhoneValid(fieldText) {
                currentAlertVC.actions[1].isEnabled = true
                newMessage = "Your phone is okay"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                currentAlertVC.actions[1].isEnabled = false
                newMessage = "Your phone is invalid"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
        default:
            break
        }
        
        let attributedString = NSAttributedString(string: newMessage, attributes: attributes)
        currentAlertVC.setValue(attributedString, forKey: "attributedMessage")
        
    }
}
