//
//  LoginVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //TextFields
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    //Buttons
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var callUsButton: UIButton!
    
    private var currentAlertVC: UIAlertController!
    private var activeTextField = UITextField()
    
    var emailFromRegistration: String?
    
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
    }
    
    func updateUILabelsWithLocalizedText() {

        emailField.placeholder = "email".localized()
        passwordField.placeholder = "password".localized()
        
        logInButton.setTitle("log_in".localized(), for: .normal)
        forgotPasswordButton.setTitle("forgot_your_password".localized(), for: .normal)
        registerButton.setTitle("register".localized(), for: .normal)
        callUsButton.setTitle("call_us".localized(), for: .normal)
        
        if let email = emailFromRegistration {
            emailField.text = email
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        var errorMessages = [String]()
        var email = ""
        var password = ""
        
        if let unwrappedEmail = emailField.text, Validator.isEmailValid(unwrappedEmail) {
            email = unwrappedEmail
        } else {
            errorMessages.append("email_is_not_valid".localized())
        }
        
        if let unwrappedPassword = passwordField.text, Validator.isPasswordValid(unwrappedPassword) {
            password = unwrappedPassword
        } else {
            errorMessages.append("password_is_not_valid".localized())
        }
        
        if errorMessages.count > 0 {
            let alertTitle = "login_error".localized()
            Alert().presentAlertWith(title: alertTitle, andMessages: errorMessages, completionHandler: { (alertContoller) in
                self.present(alertContoller, animated: true, completion: nil)
            })
            return
        }
        
        let loginData = NetworkManager.LoginUserData(
            email: email,
            password: password
        )
        
        NetworkManager().loginWith(loginData) { errorMessages in
            if let errorMessages = errorMessages {
                Alert().presentAlertWith(messages: errorMessages, completionHandler: { alertController in
                    self.present(alertController, animated: true, completion: nil)
                })
            } else {
                self.performSegue(withIdentifier: "EnterFromLogin", sender: nil)
            }
        }
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "RegisterFromLogin", sender: nil)
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_555_549)
    }
    
    deinit {
        removeKeyboardNotifications()
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue) {
        
    }
}

// Methods, that helps hide Keyboard
extension LoginVC: UITextFieldDelegate {
    // Tutorial Move textfield up when Keyboard appears https://www.youtube.com/watch?v=AiYCStoj0lc
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
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

//Recovery password
extension LoginVC {
    
    @IBAction func forgotPasswordButtonPressed(_ sender: UIButton) {
        showAlertToRestorePassword()
    }
    
    func showAlertToRestorePassword() {
        let alertTitle = "restore_password".localized()
        let alertMessage = "check_email_restore_password".localized()
        //let alertMessage = "restore_password_alert_message".localized()
        
        let cancelButtonText = "cancel".localized()
        let sendButtonText = "restore".localized()
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        currentAlertVC = alertController
        
        let alertActionCancel = UIAlertAction(title: cancelButtonText, style: .cancel, handler: nil)
        let alertActionOk = UIAlertAction(title: sendButtonText, style: .default) { [weak alertController] (_) in
            self.saveUserInfoFromAlertTextField(alertController)
        }
        
        alertController.addAction(alertActionCancel)
        
        makeTextFieldForAlertController(alertVC: alertController)
        alertController.addAction(alertActionOk)
        
        present(alertController, animated: true)
    }
    
    func makeTextFieldForAlertController(alertVC: UIAlertController) {
        
        alertVC.addTextField { (textField) in
            textField.text = self.emailField.text
            textField.placeholder = "email".localized()
            textField.keyboardType = UIKeyboardType.emailAddress
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let fieldText = textField.text else { return }
        var newMessage = ""
        var attributes = [ NSAttributedStringKey.foregroundColor : UIColor.black ]
        
        if Validator.isEmailValid(fieldText) {
            newMessage = "email_is_ok".localized()
            attributes = [ NSAttributedStringKey.foregroundColor : UIColor.green ]
        } else {
            newMessage = "email_is_not_valid".localized()
            attributes = [ NSAttributedStringKey.foregroundColor : UIColor.red ]
        }
        
        let attributedString = NSAttributedString(string: newMessage, attributes: attributes)
        currentAlertVC.setValue(attributedString, forKey: "attributedMessage")
        
    }
    
    func saveUserInfoFromAlertTextField(_ alertController: UIAlertController?) {
        guard let alertFieldText = alertController?.textFields?[0].text else { return }
        let recoveryData = NetworkManager.RecoveryUserData(email: alertFieldText)
        NetworkManager().recoveryUserPassword(recoveryData) { (message) in
            guard let alertMessage = message else { return }
            let alertTitle = "recovery_status".localized()
            Alert().presentAlertWith(title: alertTitle, andMessages: alertMessage) { alertVC in
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
}

