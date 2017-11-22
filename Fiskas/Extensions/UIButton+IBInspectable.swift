//
//  UIButton+IBInspectable.swift
//  Fiskas
//
//  Created by Yaroslav Zhurbilo on 22.11.17.
//  Copyright © 2017 Yaroslav Zhurbilo. All rights reserved.
//

import UIKit

extension UIButton {
    
    @IBInspectable override var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue  }
        get { return layer.cornerRadius }
    }
    
    @IBInspectable override var borderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor  }
        get {
            if let color = layer.borderColor {
                return UIColor.init(cgColor: color)
            } else {
                return nil
            }
        }
    }
}

