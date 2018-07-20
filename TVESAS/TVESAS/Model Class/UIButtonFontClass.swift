//
//  UIButtonFontClass.swift
//  BeautyAcadmy
//
//  Created by iMark_IOS on 09/03/18.
//  Copyright © 2018 iMark_IOS. All rights reserved.
//

import UIKit

class UIButtonFontClass: UIButton
    
{
    
    override func awakeFromNib() {
        changeSize()
        
    }
    
    fileprivate func changeSize() {
        let currentSize = self.titleLabel?.font.pointSize
        let fontDescriptor = self.titleLabel?.font.fontDescriptor
        if (UIScreen.main.bounds.height != 736){
            self.titleLabel?.font = UIFont(descriptor: fontDescriptor!, size: currentSize!-3)
        }
        
    }
    
    
    


}
