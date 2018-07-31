//
//  ViewController.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ViewController: UIViewController,UITextFieldDelegate
{
    @IBOutlet weak var btn_Setpin : UIButton!
    @IBOutlet weak var btn_Signup : UIButton!
    @IBOutlet weak var txt_PhoneNumber : UITextField!
    @IBOutlet weak var txt_pin : UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    

    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
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
       loginUserOnServer()
    }
    func isValidate() -> Bool
    {
        if txt_PhoneNumber.isEmpty
        {
            txt_PhoneNumber.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter Phone number!", onViewController: self)
            return false
        }
        if txt_pin.isEmpty
        {
            txt_pin.becomeFirstResponder()
            Utils.showAlertWithMessage(message: "Please enter Password!", onViewController: self)
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
//MARK: Service call
extension ViewController
{
    func loginUserOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            let paramDict: Parameters = ["task": "getUserDetails","contact_no":txt_PhoneNumber.text!,
                                         "password":txt_pin.text!,
                                         "device_type": "ios",
                                         "device_key": "",
                                         "userTimeZone" :localTimeZoneNamee ]
            print(paramDict)
            print("deviceTokendeviceToken",DeviceToken)
            
            let manager = Networkmanager()
            manager.loginWithParam(params: paramDict, completionBlock:
                { (response) in
                    print("\(response)")
                    
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
            print(print("Loginjsonresponse==",jsonResp))
            
            var statusmessage = String()
            statusmessage = jsonResp.value(forKey:"status_message") as! String
            
            if(Utils.returnStringFor(value: jsonResp.value(forKey: kStatus)) == "200")
            {
                if let dataDict = jsonResp.value(forKey: kData) as? NSDictionary
                {
                    print("Logindatadict==",dataDict)
                    let User_id =  dataDict["user_id"] as? String
                    let str_email =  dataDict["email"] as? String
                    let str_name =  dataDict["first_name"] as? String
                    let str_contactNo =  dataDict["contact_no"] as? String
                    let str_city =  dataDict["city"] as? String
                    
                    
                    
                    let User_DeviceId =  dataDict["device_token"] as? String
                    kUserDefault.setValue(User_id, forKey:"user_id");
                    kUserDefault.setValue(User_DeviceId, forKey:"user_Device_id");
                    
                    
                    
                    kUserDefault.setValue(User_id, forKey:"user_id");
                    kUserDefault.setValue(str_email, forKey:"UserEmailID");
                    kUserDefault.setValue(str_name?.capitalized, forKey:"UserName");
                    kUserDefault.setValue(str_contactNo, forKey:"UserMobile");
                    kUserDefault.setValue(str_city, forKey:"Usercity");
                    
                    
                    
                    let str_image1 =  dataDict["user_image"] as? String
                    print("hihihihihihi",str_image1!)
                    
                    kUserDefault.setValue(str_image1, forKey:"img_profileimage")
                    kUserDefault.setValue(str_image1, forKey:"UserImage")
                    
                    
                    
                    moveToHome()
                }
            }
            else
            {
                Utils.showAlertWithMessage(message:statusmessage, onViewController: self)
            }
        }
    }
    func  moveToHome()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    func responseFailure(error : Error)
    {
        Utils.dismissProgressHud()
        Utils.showAlertWithMessage(message:"Please try again.!", onViewController: self)
    }
    
}

