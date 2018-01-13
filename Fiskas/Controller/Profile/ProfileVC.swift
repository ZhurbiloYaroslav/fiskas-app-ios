//
//  ProfileVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import SWRevealViewController
import GKActionSheetPicker

class ProfileVC: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    // Personal Data
    @IBOutlet weak var firstNameHeaderLabel: UILabel!
    @IBOutlet weak var firstNameTextLabel: UILabel!
    
    @IBOutlet weak var lastNameHeaderLabel: UILabel!
    @IBOutlet weak var lastNameTextLabel: UILabel!
    
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
    @IBOutlet weak var passwordTextLabel: UILabel!
    @IBOutlet weak var privacyPolicyHeaderLabel: UILabel!
    
    var emailForLoginVC: String?
    
    var currentAlertVC: UIAlertController!
    var textFieldTypeInCurrentAlertVC: ProfileField!
    var actionSheetPicker: GKActionSheetPicker!
    
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
        passwordTextLabel.text = "change_password".localized()
        privacyPolicyHeaderLabel.text = "privacy_policy".localized()
        
    }
    
    func updateLabelsWithUserInfo() {
        firstNameTextLabel.text = CurrentUser.firstName
        lastNameTextLabel.text = CurrentUser.lastName
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
            return 4
        case 1:
            return 7
        case 2:
            return 2
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0,0]:
            showAlertToChange(field: .FirstName)
        case [0,1]:
            showAlertToChange(field: .LastName)
        case [0,2]:
            showAlertToChange(field: .Email)
        case [0,3]:
            showAlertToChange(field: .Phone)
        case [1,0]:
            showAlertToChange(field: .CompanyName)
        case [1,1]:
            showAlertToChange(field: .CompanyAddress)
        case [1,2]:
            showAlertToChange(field: .NIP)
        case [1,3]:
            showAlertToChange(field: .REGON)
        case [1,4]:
            showAlertToChange(field: .CompanyEmail)
        case [1,5]:
            showAlertToChange(field: .CompanyPhone)
        case [1,6]:
            showPickerToChangeTax()
        case [2,0]:
            showAlertToChange(field: .Password)
        case [2,1]:
            performSegue(withIdentifier: "ShowPrivacyPolicyVC", sender: nil)
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
        case Phone
        case CompanyName
        case CompanyAddress
        case NIP
        case REGON
        case CompanyEmail
        case CompanyPhone
        case TaxService
        case Password
    }

}

// Action Sheet 
extension ProfileVC { // extension ProfileVC: GKActionSheetPickerDelegate
    
    func showPickerToChangeTax() {
        let pickerItems = [
            "tax_type_vat".localized(),
            "tax_type_pit".localized(),
            "tax_type_ryc".localized(),
            "tax_type_kar".localized(),
            "tax_type_cit".localized()
        ]
        actionSheetPicker = GKActionSheetPicker.stringPicker(
            withItems: pickerItems,
            selectCallback: { (selected) in
                guard let selectedValue = selected as? String else { return }
                self.taxService_ValueLabel.text = selectedValue
                CurrentCompany.taxService = selectedValue
                self.updateValuesOnServer()
        },
            cancelCallback: nil)
        actionSheetPicker.present(on: self.view)
    }
}

extension ProfileVC {
    
    func showAlertToChange(field: ProfileField) {
        print("it should show alert!!!")
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
            alertController.message = "\(alertMessage): First name"
        case .LastName:
            alertController.title = "Change Last name"
            alertController.message = "\(alertMessage): Last name"
        case .Email:
            alertController.title = "Change Email"
            alertController.message = "\(alertMessage): Email"
        case .Phone:
            alertController.title = "Change Phone"
            alertController.message = "\(alertMessage): Phone"
        case .CompanyName:
            alertController.title = "Change Company name"
            alertController.message = "\(alertMessage): Company name"
        case .CompanyAddress:
            alertController.title = "Change Company address"
            alertController.message = "\(alertMessage): Company address"
        case .NIP:
            alertController.title = "Change Company NIP"
            alertController.message = "\(alertMessage): Company NIP"
        case .REGON:
            alertController.title = "Change Company REGON"
            alertController.message = "\(alertMessage): Company REGON"
        case .CompanyEmail:
            alertController.title = "Change Company email"
            alertController.message = "\(alertMessage): Company email"
        case .CompanyPhone:
            alertController.title = "Change Company phone"
            alertController.message = "\(alertMessage): Company phone"
        case .TaxService:
            alertController.title = "Change Company tax service"
            alertController.message = "\(alertMessage): Company tax service"
        case .Password:
            alertController.title = "Change Password"
            alertController.message = "\(alertMessage): Password"
        }
        
        makeTextFieldsForAlertController(alertVC: alertController, field: field)
        alertController.addAction(alertActionOk)
        
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
            case .CompanyName:
                CurrentCompany.name = alertFieldText
            case .CompanyAddress:
                CurrentCompany.address = alertFieldText
            case .NIP:
                CurrentCompany.nip = alertFieldText
            case .REGON:
                CurrentCompany.regon = alertFieldText
            case .CompanyEmail:
                CurrentCompany.email = alertFieldText
            case .CompanyPhone:
                CurrentCompany.phone = alertFieldText
            case .TaxService:
                CurrentCompany.taxService = alertFieldText
            case .Password:
                guard let newUserPassword = currentAlertVC?.textFields?[1].text else { return }
                CurrentUser.password = newUserPassword
            }
        }
        self.updateValuesOnServer()
        self.updateLabelsWithUserInfo()
        self.tableView.reloadData()
    }
    
    func updateValuesOnServer() {
        NetworkManager().updateValues { (arrayWithMessages) in
            guard let unwrappedArrayWithMessages = arrayWithMessages else { return }
            Alert().presentAlertWith(title: "Update server data", andMessages: unwrappedArrayWithMessages) { alertVC in
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    func makeTextFieldsForAlertController(alertVC: UIAlertController, field: ProfileField) {
        
        currentAlertVC = alertVC
        textFieldTypeInCurrentAlertVC = field
        
        alertVC.addTextField { textField in
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
            case .Phone:
                textField.placeholder = "Phone"
                textField.text = CurrentUser.phone
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .CompanyName:
                textField.placeholder = "Company name"
                textField.text = CurrentCompany.name
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .CompanyAddress:
                textField.placeholder = "Company address"
                textField.text = CurrentCompany.address
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .NIP:
                textField.placeholder = "Company NIP"
                textField.text = CurrentCompany.nip
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .REGON:
                textField.placeholder = "Company REGON"
                textField.text = CurrentCompany.regon
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .CompanyEmail:
                textField.placeholder = "Company Email"
                textField.text = CurrentCompany.email
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .CompanyPhone:
                textField.placeholder = "Company Phone"
                textField.text = CurrentCompany.phone
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            case .TaxService:
                textField.placeholder = "Company Tax service"
                textField.text = CurrentCompany.taxService
                textField.autocapitalizationType = UITextAutocapitalizationType.sentences
            case .Password:
                textField.tag = 0
                textField.text = ""
                textField.placeholder = "Current password"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            }
        }
        if field == .Password {
            alertVC.addTextField(configurationHandler: { textField in
                textField.tag = 1
                textField.text = ""
                textField.placeholder = "New password"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            })
            alertVC.addTextField(configurationHandler: { textField in
                textField.tag = 2
                textField.text = ""
                textField.placeholder = "Repeat new password"
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            })
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let fieldText = textField.text else { return }
        var newMessage = ""
        var attributes = [ NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        switch textFieldTypeInCurrentAlertVC {
        case .Email, .CompanyEmail:
            if Validator.isEmailValid(fieldText) {
                currentAlertVC.actions[1].isEnabled = true
                newMessage = "Your email is okay"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                currentAlertVC.actions[1].isEnabled = false
                newMessage = "Your email is invalid"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
        case .Phone, .CompanyPhone:
            if Validator.isPhoneValid(fieldText) {
                currentAlertVC.actions[1].isEnabled = true
                newMessage = "Your phone is okay"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            } else {
                currentAlertVC.actions[1].isEnabled = false
                newMessage = "Your phone is invalid"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
        case .Password:
            
            guard let passwordFieldCurrent = currentAlertVC?.textFields?[0] else { return }
            guard let passwordFieldNew = currentAlertVC?.textFields?[1] else { return }
            guard let passwordFieldRepeat = currentAlertVC?.textFields?[2] else { return }
            
            // Chenk whetger passwords are valid
            if Validator.isPasswordValid(passwordFieldCurrent.text) == false {
                currentAlertVC.actions[1].isEnabled = false
                newMessage += "Your current password is invalid \n"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            if passwordFieldCurrent.text != CurrentUser.password {
                currentAlertVC.actions[1].isEnabled = false
                newMessage += "Your current password is not match to your password \n"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
            if Validator.isPasswordValid(passwordFieldNew.text) == false
                && passwordFieldNew.text != "" {
                currentAlertVC.actions[1].isEnabled = false
                newMessage += "Your new password is invalid \n"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
            if Validator.isPasswordValid(passwordFieldRepeat.text) == false
                && passwordFieldRepeat.text != "" {
                currentAlertVC.actions[1].isEnabled = false
                newMessage += "Your repeated password is invalid \n"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
            if passwordFieldNew.text != passwordFieldRepeat.text
                && passwordFieldRepeat.text != "" {
                currentAlertVC.actions[1].isEnabled = false
                newMessage += "Your passwords are not equal \n"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
            }
            
            if Validator.isPasswordValid(passwordFieldCurrent.text)
                && Validator.isPasswordValid(passwordFieldNew.text)
                && Validator.isPasswordValid(passwordFieldRepeat.text)
                && passwordFieldCurrent.text == CurrentUser.password
                && passwordFieldNew.text == passwordFieldRepeat.text {
                
                currentAlertVC.actions[1].isEnabled = true
                newMessage += "Your passwords are validated"
                attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
            }
            
        default:
            break
        }
        
        let attributedString = NSAttributedString(string: newMessage, attributes: attributes)
        currentAlertVC.setValue(attributedString, forKey: "attributedMessage")
        
    }
}
