//
//  ShowPhotoVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 28.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class ShowPhotoVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    var takenPhoto:UIImage?
    
    override var prefersStatusBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUILabelsWithLocalizedText()
        
        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "show_photo".localized()
        cancelButton.setTitle("photo_button_cancel".localized(), for: .normal)
        acceptButton.setTitle("photo_button_accept".localized(), for: .normal)
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        goBackToPhotoVC()
    }
    
    func goBackToPhotoVC() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func acceptButtonPressed(_ sender: UIButton) {
        showAlertToAcceptImage()
    }
    
    func showAlertToAcceptImage() {
        let alertTitle = "photo_send_alert_title".localized()
        let alertMessage = "photo_send_alert_message".localized()
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "photo_send_alert_image_name".localized()
        }
        let okActionTitle = "photo_send_button_send".localized()
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { (action) in
            
            guard let photo = self.takenPhoto else { return }
            guard let imageName = alertController.textFields?[0].text else { return }
            self.uploadPhoto(photo, withName: imageName)
            
        }
        
        let deleteActionTitle = "photo_send_button_delete".localized()
        let cancelAction = UIAlertAction(title: deleteActionTitle, style: .destructive) { (action) in
            self.goBackToPhotoVC()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadPhoto(_ photo: UIImage, withName imageName: String) {
        
        let uploadData = NetworkManager.UploadPhotoData(
            email: CurrentUser.email,
            password: CurrentUser.password,
            photoTitle: imageName,
            photoBody: photo
        )
        
        NetworkManager().uploadPhoto(uploadData, completionHandler: { (arrayWithErrorMessages) in
            self.showAlertThatImageWasSent()
        })
    }
    
    func showAlertThatImageWasSent() {
        let alertTitle = "photo_send_status_ok_title".localized()
        let alertMessage = "photo_send_status_ok_title".localized()
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let okActionTitle = "ok".localized()
        let okAction = UIAlertAction(title: okActionTitle, style: .default) { (action) in
            self.goBackToPhotoVC()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
