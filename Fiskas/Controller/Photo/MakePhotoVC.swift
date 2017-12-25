//
//  MakePhotoVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 12.12.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit
import Photos
import SWRevealViewController

class MakePhotoVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    
    @IBOutlet weak var captureButton: UIButton!
    
    @IBOutlet weak var capturePreviewView: UIView!
    
    let cameraController = CameraController()
    
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewDidLoad() {
        
        setupLeftMenu()
        updateUILabelsWithLocalizedText()
        styleCaptureButton()
        configureCameraController()
        
    }
    
    func setupLeftMenu() {
        
        if revealViewController() != nil {
            menuButton.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    func updateUILabelsWithLocalizedText() {
        
        navigationItem.title = "make_photo".localized()
        libraryButton.setTitle("choose_photo".localized(), for: .normal)
        
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
}

extension MakePhotoVC {
    
    @IBAction func takePhotoFromLibrary(_ sender: UIButton) {
        openPhotoLibrary()
    }
    
    func configureCameraController() {
        cameraController.prepare {(error) in
            if let error = error {
                print(error)
            }
            
            try? self.cameraController.displayPreview(on: self.capturePreviewView)
        }
    }
    
    func styleCaptureButton() {
        captureButton.layer.borderColor = Constants.Color.redDevslopes.cgColor
        captureButton.layer.borderWidth = 0
        
        captureButton.layer.cornerRadius = min(captureButton.frame.width, captureButton.frame.height) / 2
    }
}

extension MakePhotoVC {
    
    @IBAction func captureImage(_ sender: UIButton) {
        cameraController.captureImage {(image, error) in
            guard let image = image else {
                print(error ?? "Image capture error")
                return
            }
            
            self.presentChosenImage(image: image)
        }
    }
    
}

extension MakePhotoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.dismiss(animated: true, completion: {
                self.presentChosenImage(image: chosenImage)
            })
        }
    }
    
    func presentChosenImage(image: UIImage) {
        let photoVC = UIStoryboard(name: "Photo", bundle: nil).instantiateViewController(withIdentifier: "ShowPhotoVC") as! ShowPhotoVC
        
        photoVC.takenPhoto = image
        
        present(photoVC, animated: true, completion: {
            
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

