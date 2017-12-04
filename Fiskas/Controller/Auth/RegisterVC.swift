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
    
    //Buttons
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var callUsButton: UIButton!
    
    private var activeTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeDelegates()
        updateUILabelsWithLocalizedText()
    }
    
    func initializeDelegates() {
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    func updateUILabelsWithLocalizedText() {
        
        emailField.placeholder = "email".localized()
        passwordField.placeholder = "password".localized()
        
        registerButton.setTitle("register".localized(), for: .normal)
        loginButton.setTitle("have an account?".localized(), for: .normal)
        callUsButton.setTitle("call us".localized(), for: .normal)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "EnterFromRegister", sender: nil)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginFromRegister", sender: nil)
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
        Browser.openURLWith(.Call_555_549)
    }
    
    deinit {
        removeKeyboardNotifications()
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
