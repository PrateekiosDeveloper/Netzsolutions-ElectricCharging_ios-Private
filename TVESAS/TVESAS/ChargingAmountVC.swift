//
//  ChargingAmountVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 26/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ChargingAmountVC: UIViewController
{
     var str_chargingcode = String()
    var timing = String()
    @IBOutlet weak var lbl_Working_status : UILabel!
    @IBOutlet weak var lbl_Capacity_level : UILabel!
    @IBOutlet weak var lbl_Charger_code : UILabel!
     @IBOutlet weak var lbl_slidervalue : UILabel!
      @IBOutlet weak var lbl_totalAmount : UILabel!
    
    @IBOutlet weak var lbl_manufacturarName : UILabel!
    
     @IBOutlet weak var slidervalue: UISlider!
    
    @IBOutlet weak var btn_pay : UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("ChargingAmountVC",str_chargingcode)
        
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        ChargingDetailOnServer()
        btn_pay.isHidden = true
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func BackButtonclick(_sender : UIButton)
    {
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func PayButtonclick(_sender : UIButton)
    {
        PayOnServer()
    }
    
    @IBAction func sliderValueChanged(sender: UISlider)
    {
        print("slider.valuuue",slidervalue.value)
        timing = String(slidervalue.value)
        print("hihihihih",timing)
        lbl_slidervalue.text = timing
        btn_pay.isHidden = true
    }
    
    @IBAction func CalculateAmount(_sender : UIButton)
    {
       ChargingAmountOnServer()
    }
}
//MARK: Service call
extension ChargingAmountVC
{
    func ChargingDetailOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            
            
            let paramDict: Parameters = ["task": "getMachineDetail","code":str_chargingcode]
            
            print("parameter",paramDict)
            let manager = Networkmanager()
            manager.GetchargerDetailWithParam(params: paramDict, completionBlock:
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
                    
               
                    
                     let str_capacitylevel = (dataDict.value(forKey: "kwh_level") as? String)!
                     let str_machinestatus =  (dataDict.value(forKey: "machine_status") as? String)!
                       let str_manufacturarName =  (dataDict.value(forKey: "manufacturer_name") as? String)!
                    
                      print("str_capacitylevel==",str_capacitylevel)
                      print("str_machinestatus==",str_machinestatus)
                    
                    
                    lbl_Charger_code.text = str_chargingcode
                    lbl_Capacity_level.text = String(format: "Voltage: %@", str_capacitylevel)
                    lbl_Working_status.text = str_machinestatus
                    lbl_manufacturarName.text = str_manufacturarName
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
    func ChargingAmountOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            
            
            let paramDict: Parameters = ["task": "getChargingPrice","code":str_chargingcode , "duration": lbl_slidervalue.text!]
            
            print("parameter",paramDict)
            let manager = Networkmanager()
            manager.GetchargerDetailWithParam(params: paramDict, completionBlock:
                { (response) in
                    
                    
                    switch response.result
                    {
                    case .success:
                        self.successfullChargingamountReceivedResponse(response: response)
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
    func successfullChargingamountReceivedResponse(response: DataResponse<Any>)
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
                    let str_totalAmount = (dataDict.value(forKey: "price") as? String)!
                    print("str_totalAmount==",str_totalAmount)
                    lbl_totalAmount.text = str_totalAmount
                    btn_pay.isHidden = false
               }
            }
            else
            {
                Utils.showAlertWithMessage(message:statusmessage, onViewController: self)
            }
        }
    }
    func PayOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            
            if timing == ""
            {
               timing = "30"
            }
            
            let paramDict: Parameters = ["task": "PaymentRequest","user_id":kUserDefault.object(forKey:"user_id")! as Any , "code": str_chargingcode, "amount":lbl_totalAmount.text!,"duration": timing]
            
            print("parameter",paramDict)
            let manager = Networkmanager()
            manager.GetchargerDetailWithParam(params: paramDict, completionBlock:
                { (response) in
                    
                    
                    switch response.result
                    {
                    case .success:
                        self.successfullPayReceivedResponse(response: response)
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
    func successfullPayReceivedResponse(response: DataResponse<Any>)
    {
        Utils.dismissProgressHud()
        if let result = response.result.value
        {
            let jsonResp = result as! NSDictionary
             print("jsonRespjsonResp==",jsonResp)
            var statusmessage = String()
            statusmessage = jsonResp.value(forKey:"status_message") as! String
            print("PaymentPayment",statusmessage)
            if(Utils.returnStringFor(value: jsonResp.value(forKey: kStatus)) == "200")
            {
                if let dataDict = jsonResp.value(forKey: kData) as? NSDictionary
                {
                    print("Signupdatadictpay==",dataDict)
                   
                    if statusmessage == "SUCCESS"
                    {
                       let paymenid = dataDict.value(forKey:"PAYMENT_ID") as! NSNumber
                        
                         print("paymenidpaymenid==",paymenid)
                          print("timingtiming==",timing)
                          print("str_chargingcode==",str_chargingcode)
                        
                        
                          kUserDefault.setValue(timing, forKey:"Charging_Time");
                          kUserDefault.setValue(paymenid, forKey:"chargingPaymentID");
                          kUserDefault.setValue(str_chargingcode, forKey:"chargingCode");
                        
                        
                        
                         let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "StartChargingVC") as? UINavigationController
                         self.present(EditProfileVCObj!, animated: true, completion: nil)
                    }
                    else
                    {
                        Utils.showAlertWithMessage(message: statusmessage, onViewController: self)
                    }
             
                }
            }
            else
            {
                Utils.showAlertWithMessage(message:statusmessage, onViewController: self)
            }
        }
    }
}
