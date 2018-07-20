//
//  UITextFieldCustomClass.swift
//  SureshotGPS
//
//  Created by Piyush Gupta on 8/31/16.
//  Copyright © 2016 Piyush Gupta. All rights reserved.
//

import UIKit

@IBDesignable class UITextFieldCustomClass: UITextFieldFontSize {
    
    @IBInspectable var horizontalInset:CGFloat = 10

    @IBInspectable var placeholderColor: UIColor = UIColor.black {
        didSet {
            if let placeholder = self.placeholder {
                let attributes = [NSAttributedStringKey.foregroundColor: placeholderColor]
                attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
            }
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor:UIColor {
        get { return UIColor(cgColor: layer.borderColor!) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: 0)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: horizontalInset, dy: 0)
    }
    @IBInspectable var shadowColor:UIColor
        {get{ return UIColor(cgColor: layer.shadowColor!)}
        set{ layer.shadowColor = newValue.cgColor }
    }
    
    @IBInspectable var shadowOpacity:CGFloat {
        get { return CGFloat(layer.shadowOpacity) }
        set { layer.shadowOpacity = Float(newValue) }
    }
    
    
    @IBInspectable var shadowRadius:CGFloat {
        get { return layer.shadowRadius }
        set { layer.shadowRadius = newValue }
    }
    
    @IBInspectable var shadowOffset:CGSize {
        get { return layer.shadowOffset }
        set { layer.shadowOffset = newValue }
    }

}
