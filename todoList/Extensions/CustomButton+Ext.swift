//
//  Button+Ext.swift
//  todoList
//
//  Created by 안주환 on 2023/02/11.
//

import Foundation
import UIKit

@IBDesignable
class CustomButton : UIButton {
    
    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var borderRadius : CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = borderRadius
        }
    }
    
}
