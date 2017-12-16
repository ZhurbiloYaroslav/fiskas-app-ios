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
            
            self.showAlertThatImageWasSent()
        }
        
        let cancelAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            self.goBackToPhotoVC()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertThatImageWasSent() {
        let alertController = UIAlertController(title: "Image sent", message: "The image has been sent to the server", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.goBackToPhotoVC()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
