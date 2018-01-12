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
    var invoiceImage: UIImage?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        invoiceImageView.image = invoiceImage
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(invoiceImageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Saved!", message: "Your invoice has been saved to your photos", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
}
