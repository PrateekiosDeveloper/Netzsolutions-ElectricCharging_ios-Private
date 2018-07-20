//
//  SignupVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class SignupVC: UIViewController,UITextFieldDelegate
{

      @IBOutlet weak var txt_PhoneNumber : UITextField!
       @IBOutlet weak var txt_verify : UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Signinclicked(_sender : UIButton)
    {
      self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func Signupclicked(_sender : UIButton)
    {
        let SetPinVCObj = self.storyboard?.instantiateViewController(withIdentifier: "SetPinVC") as? SetPinVC
        SetPinVCObj?.phonenumber = txt_PhoneNumber.text!
         SetPinVCObj?.classname = "signup"
        self.navigationController?.pushViewController(SetPinVCObj!, animated: true)
    }
    
    @IBAction func Verifyclicked(_sender : UIButton)
    {
       
    }
}
