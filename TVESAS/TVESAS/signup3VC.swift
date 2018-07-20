//
//  signup3VC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class signup3VC: UIViewController,UITextFieldDelegate
{
   
       @IBOutlet weak var btn_Register : UIButton!
       @IBOutlet weak var txt_Username: UITextField!
       @IBOutlet weak var txt_Email : UITextField!
       @IBOutlet weak var txt_cityname : UITextField!
       @IBOutlet weak var txt_Profileimage : UITextField!
      @IBOutlet weak var img_profile : UIImageView!
      var phonenumber = String()
     var pwd = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Registerclicked(_sender : UIButton)
    {
        if isValidate()
        {
            callSignIn_WS()
        }
    }
    
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callSignIn_WS()
    {
       SignupUserOnServer()
    }
    
    func isValidate() -> Bool
    {
        if txt_Username.isEmpty
        {
            txt_Username.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter User name!", onViewController: self)
            return false
        }
        if txt_Email.isEmpty
        {
            txt_Email.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter Email!", onViewController: self)
            return false
        }
        if !txt_Email.hasValidEmail
        {
            txt_Email.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter valid Email-Id!", onViewController: self)
            return false
        }
        if txt_cityname.isEmpty
        {
            txt_cityname.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter City name!", onViewController: self)
            return false
        }
      
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        if textField == txt_Username
        {
            txt_Email.becomeFirstResponder()
        }
        
        if textField == txt_Email
        {
            txt_cityname.becomeFirstResponder()
        }
        
        if textField == txt_cityname
        {
            txt_Profileimage.becomeFirstResponder()
        }
        
        return true
    }

}
//MARK: Service call
extension signup3VC
{
    func SignupUserOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
         
            
            let paramDict: Parameters = ["task": "addUser","email":txt_Email.text!,
                                         "password": pwd,
                                         "first_name":txt_Username.text!,
                                         "last_name": "",
                                         "city": txt_cityname.text! ,
                                          "state": "",
                                         "country": "",
                                         "contact_no":phonenumber,
                                         "device_type": "ios",
                                         "device_key": "65e4f0ad0030bc6117b44cad741a0ad5984351aa",
                                         "userTimeZone" : localTimeZoneNamee]
            
            print("parameter",paramDict)
            let manager = Networkmanager()
            manager.loginWithParam(params: paramDict, completionBlock:
                { (response) in
                    
                    
                    switch response.result
                    {
                    case .success:
                        self.successfullReceivedResponse(response: response)
                    case .failure(let error):
                        self.responseFailure(error: error)
                    }
            })
        }
        else
        {
            Utils.showAlertWithMessage(message: kNoInternetMsg, onViewController: self)
        }
    }
    func successfullReceivedResponse(response: DataResponse<Any>)
    {
        Utils.dismissProgressHud()
        if let result = response.result.value
        {
            let jsonResp = result as! NSDictionary
            var statusmessage = String()
            statusmessage = jsonResp.value(forKey:"status_message") as! String
            if(Utils.returnStringFor(value: jsonResp.value(forKey: kStatus)) == "200")
            {
                if let dataDict = jsonResp.value(forKey: kData) as? NSDictionary
                {
                    print("Signupdatadict==",dataDict)
                    moveToHome()
                    Utils.showAlertWithMessage(message: "Registration Successfull!", onViewController: self)
                    kUserDefault.setValue(dataDict, forKey: kUserLoginDict);
                    kUserDefault.setValue(true, forKey: kuserLoggedIn);
                    kUserDefault.setValue(dataDict.value(forKey: kAuthToken), forKey: kAuthToken)
                }
            }
            else
            {
                Utils.showAlertWithMessage(message:statusmessage, onViewController: self)
            }
        }
    }
    
    func responseFailure(error : Error)
    {
        Utils.dismissProgressHud()
        Utils.showAlertWithMessage(message:"Please try again.!", onViewController: self)
    }
  
    func  moveToHome()
    {
        let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(loginobj, animated:false)
    }
   
  
    
    
 
}
