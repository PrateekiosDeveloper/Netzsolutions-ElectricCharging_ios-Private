//
//  ViewController.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var btn_Setpin : UIButton!
    @IBOutlet weak var btn_Signup : UIButton!
    @IBOutlet weak var txt_PhoneNumber : UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setPinclicked(_sender : UIButton)
    {
        if isValidate()
        {
            callSignIn_WS()
        }
    }
    
    func callSignIn_WS()
    {
       
        let SetPinVCObj = self.storyboard?.instantiateViewController(withIdentifier: "SetPinVC") as? SetPinVC
        SetPinVCObj?.phonenumber  = txt_PhoneNumber.text!
        SetPinVCObj?.classname = "login"
        self.navigationController?.pushViewController(SetPinVCObj!, animated: true)
    }
    func isValidate() -> Bool
    {
        if txt_PhoneNumber.isEmpty
        {
            txt_PhoneNumber.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter Phone number!", onViewController: self)
            return false
        }
        return true
    }
    @IBAction func Signupclicked(_sender : UIButton)
    {
        let SignupVCObj = self.storyboard?.instantiateViewController(withIdentifier: "SignupVC") as? SignupVC
        self.navigationController?.pushViewController(SignupVCObj!, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}

