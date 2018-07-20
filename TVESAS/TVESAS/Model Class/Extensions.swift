//
//  Extensions.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 9/28/16.
//  Copyright © 2016 Yong Su. All rights reserved.
//

import UIKit
import AVFoundation

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

protocol TypeName: AnyObject {
    static var typeName: String { get }
}

// Swift Objects
extension TypeName {
    static var typeName: String {
        let type = String(describing: self)
        return type
    }
}

// Bridge to Obj-C
extension NSObject: TypeName {
    class var typeName: String {
        let type = String(describing: self)
        return type
    }
}

//MARK:- String Extension

extension String {
    
    func dateFromFormat(_ format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
    
    func formatted() -> String {
        let array = self.components(separatedBy: ".")
        let str  = array[0]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.currencySymbol = ""
        let int98: Int = Int(str)!
        var last = array.count == 1 ? "" : ".\(array[1])"
        var new = "\(formatter.string(from: NSNumber(integerLiteral: int98))!)"
        if last.characters.count > 0{
            let array = new.components(separatedBy: ".")
            let str  = array.first
            new = str!
            if last.characters.count == 2{
                last = last + "0"
            }
        }
        return new + last
    }
    
    public var trimmedTextCount: Int {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).characters.count
    }
    
    func formatetedPrice() -> String {
        
        let array = self.components(separatedBy: ".")
        let str  = array[0]
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        formatter.currencySymbol = ""
        if array.count > 1, Int(array[1])! > 0{
            return str + ".\(array[1])"
        } else {
            return str
        }
    }
    
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

extension UIScrollView {
    
    func resizeScrollViewContentSize() {
        var contentRect = CGRect.zero
        for view in self.subviews {
            contentRect = contentRect.union(view.frame)
        }
        self.contentSize = contentRect.size
    }
}

extension UITableView {
    func reloadWithAnimation() {
        let range = NSMakeRange(0, self.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.reloadSections(sections as IndexSet, with: .automatic)
    }
}


extension UITextView {
    
    public var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    public var trimmedTextCount: Int {
        return text!.trimmingCharacters(in: .whitespacesAndNewlines).characters.count
    }
    
    public var hasValidEmail: Bool {
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    public var hasValidMobile: Bool {
        let PHONE_REGEX = "^[0-9]*$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self.text)
        return result
    }
    
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    public func setCorner(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
}

extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.characters.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.darkGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.characters.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
    
}

extension UITextField {
    
    @IBInspectable
    var localizedPlaceHolder: String {
        set (key) {
            placeholder = NSLocalizedString(key, comment: "")
        }
        get {
            return placeholder!
        }
    }
    
    public var isEmpty: Bool {
        return text?.isEmpty == true
    }
    
    public var trimmedTextCount: Int {
        return text!.trimmingCharacters(in: .whitespacesAndNewlines).count
    }
    
    public var hasValidEmail: Bool
    {
        return text!.range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,}",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
    }
    
    public var hasValidMobile: Bool
    {
//        let PHONE_REGEX = "^[0-9]*$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: self.text)
        
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
//        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
//        let result =  phoneTest.evaluate(with: value)
//        return result
        
        return text!.range(of: "[0-9]",
                           options: String.CompareOptions.regularExpression,
                           range: nil, locale: nil) != nil
        
    }
    
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    public func setCorner(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    public func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = placeholder, !holder.isEmpty else {
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: holder, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    
    public func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .right
        self.leftView = imageView
        self.leftView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    public func addPaddingLeftIconWithoutImage(padding: CGFloat) {
        let view = UIView()
        view.frame = CGRect.init(x: 0, y: 0, width: Int(padding), height: Int(padding))
        view.contentMode = .right
        self.leftView = view
        self.leftView?.frame.size = CGSize(width: view.frame.size.width + padding, height: view.frame.size.height)
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    func setBottomBorder(color: UIColor) {
        self.borderStyle = .none
        self.layer.backgroundColor = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    

    
}







    
//    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
//        let border = CALayer()
//        border.backgroundColor = color.cgColor
//        switch side {
//        case .Top:
//            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
//        case .Bottom:
//            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
//        case .Left:
//            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
//        case .Right:
//            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
//        }
//        self.layer.addSublayer(border)
//    }

    






extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

extension UIImageView {
    func tintImageColor(color : UIColor) {
        self.image = self.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.tintColor = color
    }
}






//Extensiion For Localize String

extension UILabel {
    
    @IBInspectable
    var localizedText: String {
        set (key) {
            text = NSLocalizedString(key, comment: "")
        }
        get {
            return text!
        }
    }
    
}

extension UIButton {
     @IBInspectable
    var localizedTitleForNormal: String {
        set (key) {
            setTitle(NSLocalizedString(key, comment: ""), for: .normal)
        }
        get {
            return title(for: .normal)!
        }
    }
     @IBInspectable
    var localizedTitleForHighlighted: String {
        set (key) {
            setTitle(NSLocalizedString(key, comment: ""), for: .highlighted)
        }
        get {
            return title(for: .highlighted)!
        }
    }
}
