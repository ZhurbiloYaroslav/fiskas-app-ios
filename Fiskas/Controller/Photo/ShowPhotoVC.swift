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
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "show_photo".localized()
        
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
        let alertController = UIAlertController(title: "Image status", message: "Current Image accepted", preferredStyle: .alert)
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Image name"
        }
        
        let okAction = UIAlertAction(title: "Send", style: .default) { (action) in
            
            uploadPhoto()
            
        }
        
        func uploadPhoto() {
            
            guard let photo = self.takenPhoto else { return }
            guard let stringBase64WithPhoto = photo.base64(format: .png) else { return }
            print(stringBase64WithPhoto)
            
            let uploadData = NetworkManager.UploadPhotoData(
                email: CurrentUser.email,
                password: CurrentUser.password,
                photoTitle: "TestImage",
                photoBody: stringBase64WithPhoto
            )
            
            NetworkManager().uploadPhoto(uploadData, completionHandler: { (arrayWithErrorMessages) in
                self.showAlertThatImageWasSent(arrayWithErrorMessages)
            })
        }
        
        let cancelAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.goBackToPhotoVC()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertThatImageWasSent(_ arrayWithErrorMessages: [String]?) {
        var alertMessage = ""
        if let arrayWithErrorMessages = arrayWithErrorMessages, arrayWithErrorMessages.isEmpty {
            alertMessage = "The image has been sent to the server"
        } else {
            alertMessage = "Error!"
        }
        let alertController = UIAlertController(title: "Image sent status", message: alertMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.goBackToPhotoVC()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
