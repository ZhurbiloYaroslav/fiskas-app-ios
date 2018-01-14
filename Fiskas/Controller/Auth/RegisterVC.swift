//
//  RegisterVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import GKActionSheetPicker

class RegisterVC: UIViewController {
    
    //TextFields
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    //User company fields
    @IBOutlet weak var companyNameField: UITextField!
    @IBOutlet weak var companyAddressField: UITextField!
    @IBOutlet weak var nipField: UITextField!
    @IBOutlet weak var regonField: UITextField!
    @IBOutlet weak var companyEmailField: UITextField!
    @IBOutlet weak var companyPhoneField: UITextField!
    
    //Buttons
    @IBOutlet weak var taxServiceButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var callUsButton: UIButton!
    
    private var activeTextField = UITextField()
    var actionSheetPicker: GKActionSheetPicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        updateUILabelsWithLocalizedText()
        hideKeyboardWhenTappedAround()
        registerForKeyboardNotifications()
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
        repeatPasswordField.delegate = self
        firstNameField.delegate = self
        phoneField.delegate = self
    }
    
    func updateUILabelsWithLocalizedText() {
        
        emailField.placeholder = "email".localized()
        passwordField.placeholder = "password".localized()
        repeatPasswordField.placeholder = "repeat_password".localized()
        firstNameField.placeholder = "first_name".localized()
        lastNameField.placeholder = "last_name".localized()
        phoneField.placeholder = "phone".localized()
        
        companyNameField.placeholder = "company_name".localized()
        companyAddressField.placeholder = "company_address".localized()
        nipField.placeholder = "nip".localized()
        regonField.placeholder = "regon".localized()
        companyEmailField.placeholder = "company_email".localized()
        companyPhoneField.placeholder = "company_phone".localized()
        
        taxServiceButton.setTitle("tax_type_vat".localized(), for: .normal)
        registerButton.setTitle("register".localized(), for: .normal)
        loginButton.setTitle("have_an_account".localized(), for: .normal)
        callUsButton.setTitle("call_us".localized(), for: .normal)
    }
    
    @IBAction func taxServiceButtonPressed(_ sender: UIButton) {
        showPickerToChangeTax()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        
        guard let registerData = validateFieldsAndGetRequestData() else { return }
        
        NetworkManager().registerWith(registerData) { errorMessages in
            if let errorMessages = errorMessages {
                Alert().presentAlertWith(messages: errorMessages, completionHandler: { alertController in
                    self.present(alertController, animated: true, completion: nil)
                })
            } else {
                self.performSegue(withIdentifier: "BackToLoginWithEmail", sender: nil)
            }
        }
    }
    
    func validateFieldsAndGetRequestData() -> NetworkManager.RegisterUserData? {
        var errorMessages = [String]()
        var email = ""
        var password = ""
        var firstName = ""
        var lastName = ""
        var phone = ""
        var companyName = ""
        var companyAddress = ""
        var nip = ""
        var regon = ""
        var companyEmail = ""
        var companyPhone = ""
        var companyTaxService = ""
        
        if let unwrappedEmail = emailField.text, Validator.isEmailValid(unwrappedEmail) {
            email = unwrappedEmail
        } else {
            errorMessages.append("email_is_not_valid".localized())
        }
        
        if let unwrappedPassword = passwordField.text, Validator.isPasswordValid(unwrappedPassword) {
            password = unwrappedPassword
        } else {
            errorMessages.append("password_is_not_valid".localized())
            errorMessages.append("password_should_be".localized())
        }
        
        if passwordField.text!.elementsEqual(repeatPasswordField.text!) == false {
            errorMessages.append("passwords_are_not_equal".localized())
        }
        
        if let unwrappedFirstName = firstNameField.text, Validator.isEmpty(unwrappedFirstName) == false {
            firstName = unwrappedFirstName
        } else {
            if Validator.isEmpty(firstNameField.text!) {
                errorMessages.append("first_name_should_not_be_empty".localized())
            } else if Validator.isNameValid(firstNameField.text!) {
                errorMessages.append("first_name_is_not_valid".localized())
            }
        }
        
        if let unwrappedLastName = lastNameField.text, Validator.isEmpty(unwrappedLastName) == false {
            lastName = unwrappedLastName
        } else {
            if Validator.isEmpty(lastNameField.text!) {
                errorMessages.append("last_name_should_not_be_empty".localized())
            } else if Validator.isNameValid(lastNameField.text!) {
                errorMessages.append("last_name_is_not_valid".localized())
            }
        }
        
        if let unwrappedPhone = phoneField.text, Validator.isPhoneValid(unwrappedPhone) {
            phone = unwrappedPhone
        } else {
            errorMessages.append("user_phone_is_not_valid".localized())
            errorMessages.append("phone_should_be".localized())
        }
        
        if let unwrappedCompanyName = companyNameField.text, Validator.isEmpty(unwrappedCompanyName) == false {
            companyName = unwrappedCompanyName
        } else {
            if Validator.isEmpty(companyNameField.text!) {
                errorMessages.append("company_name_should_not_be_empty".localized())
            } else if Validator.isNameValid(companyNameField.text!) {
                errorMessages.append("company_name_is_not_valid".localized())
            }
        }
        
        if let unwrappedCompanyAddress = companyAddressField.text, Validator.isEmpty(unwrappedCompanyAddress) == false {
            companyAddress = unwrappedCompanyAddress
        } else {
            if Validator.isEmpty(companyAddressField.text!) {
                errorMessages.append("company_address_should_not_be_empty".localized())
            }
        }
        
        if let unwrappedNip = nipField.text, Validator.isEmpty(unwrappedNip) == false {
            nip = unwrappedNip
        } else {
            errorMessages.append("nip_should_not_be_empty".localized())
        }
        
        if let unwrappedRegon = regonField.text, Validator.isEmpty(unwrappedRegon) == false {
            regon = unwrappedRegon
        } else {
            errorMessages.append("regon_should_not_be_empty".localized())
        }
        
        if let unwrappedCompanyEmail = companyEmailField.text, Validator.isEmailValid(unwrappedCompanyEmail) {
            companyEmail = unwrappedCompanyEmail
        } else {
            errorMessages.append("company_email_is_not_valid".localized())
        }
        
        if let unwrappedCompanyPhone = companyPhoneField.text, Validator.isPhoneValid(unwrappedCompanyPhone) {
            companyPhone = unwrappedCompanyPhone
        } else {
            errorMessages.append("company_phone_is_not_valid".localized())
            errorMessages.append("phone_should_be".localized())
        }
        
        if errorMessages.count > 0 {
            let alertTitle = "registration_error".localized()
            Alert().presentAlertWith(title: alertTitle, andMessages: errorMessages, completionHandler: { (alertContoller) in
                self.present(alertContoller, animated: true, completion: nil)
            })
            return nil
        }
        
        let registerData = NetworkManager.RegisterUserData(
            email: email,
            password: password,
            firstName: firstName,
            lastName: lastName,
            phone: phone,
            companyName: companyName,
            companyAddress: companyAddress,
            nip: nip,
            regon: regon,
            taxType: companyTaxService,
            companyEmail: companyEmail,
            companyPhone: companyPhone
        )
        
        return registerData
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_555_549)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let segueID = segue.identifier else { return }

        if let destination = segue.destination as? LoginVC, let email = emailField.text  {
            destination.emailFromRegistration = email
        }
    }
    
}

// Action Sheet
extension RegisterVC { // extension ProfileVC: GKActionSheetPickerDelegate
    
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
                self.taxServiceButton.setTitle(selectedValue, for: .normal)
        },
            cancelCallback: nil)
        actionSheetPicker.present(on: self.view)
    }
}

// Methods, that helps hide Keyboard
extension RegisterVC: UITextFieldDelegate {
    // Tutorial Move textfield up when Keyboard appears https://www.youtube.com/watch?v=AiYCStoj0lc
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        repeatPasswordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        phoneField.resignFirstResponder()
        companyNameField.resignFirstResponder()
        nipField.resignFirstResponder()
        regonField.resignFirstResponder()
        companyEmailField.resignFirstResponder()
        companyPhoneField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func registerForKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            else { return }
        let keyboardY = self.view.frame.size.height - keyboardFrameSize.height
        let editingTextFieldY = activeTextField.convert(activeTextField.bounds.origin, to: nil).y
        
        if editingTextFieldY > keyboardY - 90 {
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
                self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY - (keyboardY - 90)),
                                         width: self.view.bounds.width, height: self.view.bounds.height)
            }, completion: nil)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
}
