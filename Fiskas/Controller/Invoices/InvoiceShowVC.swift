//
//  InvoiceShowVC.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 12.01.18.
//  Copyright © 2018 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

class InvoiceShowVC: UIViewController {
    
    @IBOutlet weak var invoiceImageView: UIImageView!
    @IBOutlet weak var saveButton: UIButton!
    var invoiceImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUILabelsWithLocalizedText()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        invoiceImageView.image = invoiceImage
    }
    
    func updateUILabelsWithLocalizedText() {
        saveButton.setTitle("invoice_button_save".localized(), for: .normal)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(invoiceImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertTitle = "invoice_saved_error_title".localized()
            let alertController = UIAlertController(title: alertTitle, message: error.localizedDescription, preferredStyle: .alert)
            
            let okActionTitle = "OK".localized()
            alertController.addAction(UIAlertAction(title: okActionTitle, style: .default))
            present(alertController, animated: true)
        } else {
            let alertTitle = "invoice_saved_ok_title".localized()
            let alertMessage = "invoice_saved_ok_message".localized()
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            
            let okActionTitle = "OK".localized()
            alertController.addAction(UIAlertAction(title: okActionTitle, style: .default))
            present(alertController, animated: true)
        }
    }
}
