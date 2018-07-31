//
//  SignupVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SignupVC: UIViewController,UITextFieldDelegate
{

      @IBOutlet weak var txt_PhoneNumber : UITextField!
      @IBOutlet weak var txt_verify : UITextField!
      var rand_num = Int()
    
     var str_valuecheck = String()
    
        override func viewDidLoad()
    {
        super.viewDidLoad()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func Signupclicked(_sender : UIButton)
    {
       if isValidate()
        {
            callSignIn_WS()
        }
    }
    func isValidate() -> Bool
    {
        if txt_PhoneNumber.isEmpty
        {
            txt_PhoneNumber.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter Phonenumber!", onViewController: self)
            return false
        }
       
       return true
    }
    func callSignIn_WS()
    {
        if str_valuecheck == "check"
        {
            let SignupVCObj = self.storyboard?.instantiateViewController(withIdentifier: "signup3VC") as? signup3VC
            self.navigationController?.pushViewController(SignupVCObj!, animated: true)
        }
        else
        {
             Utils.showAlertWithMessage(message: "Please Verify Phonenumber!", onViewController: self)
        }
       
    }
    @IBAction func Verifyclicked(_sender : UIButton)
    {
         rand_num = Int(arc4random_uniform(10000))
        print("rand",rand_num)
         str_valuecheck = "check"
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: Parameters = [
            "username": "Tvesas1",
            "password":  "Tvesas2018" ,
            "sender":  "TVESAS" ,
            "sendto":  txt_PhoneNumber.text!,
            "message": rand_num
        ]
        
        Alamofire.request("http://priority.thesmsworld.com/api.php", method: .post, parameters: parameters, headers: headers).response { response in
            print("rrrrr",response)
            self.txt_verify.text =  String(self.rand_num)
            
        }
    }}
