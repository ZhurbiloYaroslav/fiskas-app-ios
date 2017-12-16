//
//  RegisterVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    //TextFields
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var repeatPasswordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    //Buttons
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var callUsButton: UIButton!
    
    private var activeTextField = UITextField()
    
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
        nameField.delegate = self
        phoneField.delegate = self
    }
    
    func updateUILabelsWithLocalizedText() {
        
        emailField.placeholder = "email".localized()
        passwordField.placeholder = "password".localized()
        repeatPasswordField.placeholder = "repeat_password".localized()
        nameField.placeholder = "name".localized()
        phoneField.placeholder = "phone".localized()
        
        registerButton.setTitle("register".localized(), for: .normal)
        loginButton.setTitle("have_an_account".localized(), for: .normal)
        callUsButton.setTitle("call_us".localized(), for: .normal)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        var errorMessages = [String]()
        var email = ""
        var password = ""
        var name = ""
        var phone = ""
                
        if let unwrappedEmail = emailField.text, Validator.isEmailValid(unwrappedEmail) {
            email = unwrappedEmail
        } else {
            errorMessages.append("Email is not valid")
        }
        
        if let unwrappedPassword = passwordField.text, Validator.isPasswordValid(unwrappedPassword) {
            password = unwrappedPassword
        } else {
            errorMessages.append("Password is not valid")
            errorMessages.append("Password should be...")
        }
        
        if passwordField.text!.elementsEqual(repeatPasswordField.text!) == false {
            errorMessages.append("Passwords are not equal")
        }
        
        if let unwrappedName = nameField.text, Validator.isEmpty(unwrappedName) == false {
            name = unwrappedName
        } else {
            if Validator.isEmpty(nameField.text!) {
                errorMessages.append("Name shouldn't be empty")
            } else if Validator.isNameValid(nameField.text!) {
                errorMessages.append("Name is not valid")
            }
            errorMessages.append("Name should be...")
        }
        
        if let unwrappedPhone = phoneField.text, Validator.isPasswordValid(unwrappedPhone) {
            phone = unwrappedPhone
        } else {
            errorMessages.append("Phone is not valid")
            errorMessages.append("Phone should be...")
        }
        
        if errorMessages.count > 0 {
            Alert().presentAlertWith(title: "Registration Error", andMessages: errorMessages, completionHandler: { (alertContoller) in
                self.present(alertContoller, animated: true, completion: nil)
            })
            return
        }
        
        let registerData = AuthManager.RegisterUserData(
            name: name,
            phone: phone,
            email: email,
            password: password
        )
        
        AuthManager().registerWith(registerData) { errorMessages in
            if let errorMessages = errorMessages {
                Alert().presentAlertWith(messages: errorMessages, completionHandler: { alertController in
                    self.present(alertController, animated: true, completion: nil)
                })
            } else {
                self.performSegue(withIdentifier: "BackToLoginWithEmail", sender: nil)
            }
        }
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
        nameField.resignFirstResponder()
        phoneField.resignFirstResponder()
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
