//
//  StartChargingVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 30/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class StartChargingVC: UIViewController
{
    
  
    @IBOutlet weak var progtress_view: UIProgressView!
     @IBOutlet weak var timerLabel: UILabel!
     @IBOutlet weak var lbl_chargingdone: UILabel!
    
    @IBOutlet weak var btn_charging: UIButton!
      @IBOutlet weak var btn_Done: UIButton!
   
     var str_chargingminute = String()
    var str_charginPaymentID = NSNumber()
    var str_chargincode = String()
    
    var seconds = 0
   
    
    var isTimerRunning = false
    var resumeTapped = false
    var timer = Timer()
    var poseDuration = 20
    var indexProgressBar = 0
    var currentPoseIndex = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.btn_Done.isHidden = true
        self.btn_charging.isHidden = false
        lbl_chargingdone.isHidden = true
        
       progtress_view.progress = 0.0
        str_chargingminute = kUserDefault.object(forKey:"Charging_Time") as! String
        str_charginPaymentID = kUserDefault.object(forKey:"chargingPaymentID") as! NSNumber
        str_chargincode = kUserDefault.object(forKey:"chargingCode") as! String
        
        
        
        
        print("str_chargingminute",str_chargingminute)
        print("str_charginPaymentID",str_charginPaymentID)
        
        print("str_chargingminuteaa",(str_chargingminute as NSString).integerValue)
        let mychargingtime = (str_chargingminute as NSString).integerValue
          //print("str_chargingminuteaa",mychargingtime)
        let duration: TimeInterval = TimeInterval(mychargingtime)
        
      //  let s: Int = Int(duration) % 60
      //  let m: Int = Int(duration) / 60
          let sec: Int = Int(duration) * 60
        
     //   let formattedDuration = String(format: "%0d:%02d", m, s)
       // print("formattedDuration",formattedDuration)
       // print("formattedDuration",s)
       //  print("formattedDuration",m)
        // print("formattedDuration",sec)
       //   print("secondsseconds",seconds)
        // seconds = sec
        seconds = sec
        //print("secondsseconds",seconds)
        
    }
    
    func getPostData(_ reqId: String, chargeId: String , payment:NSNumber) -> [String: Any]
    {

        return [

            "reqId": "2",
             "chargerID": chargeId,
            "reqType": "RemoteStartTransaction",

            "reqAttributes": [

                "items": [

                    [

                        "connectorid": "1",

                        "idTag": "RFID1",
                        
                          "paymentID": payment,

                        "userID": reqId

                    ]

                ]

            ]

        ]
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Donecharging(sender: UIButton)
    {
        moveToHome()
    }
    func  moveToHome()
    {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        navigationController?.pushViewController(vc,animated: true)
    }
    @IBAction func startcharging(sender: UIButton)
    {
        StartChargingOnServer()
        self.btn_charging.isEnabled = false
        self.btn_charging.backgroundColor = UIColor.lightGray
    }
    func runTimer()
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(StartChargingVC.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    @objc func updateTimer()
    {
        if seconds < 1
        {
            timer.invalidate()
            //Send alert to indicate time's up.
        }
        else
        {
            seconds -= 1
            timerLabel.text = timeString(time: TimeInterval(seconds))
          //  print("timerLabel",timerLabel.text!)
           //  print("TimeInterval",timeString(time: TimeInterval(seconds)))
            let val = timeString(time: TimeInterval(seconds))
            if val == "00:00:00"
            {
                self.btn_charging.isEnabled = true
                self.btn_charging.backgroundColor =  UIColor(red: 157.0, green: 202.0, blue: 75, alpha: 0.5)
                self.btn_charging.isHidden = true
                self.btn_Done.isHidden = false
                 lbl_chargingdone.isHidden = false
                
            }
        }
    }
    
    func timeString(time:TimeInterval) -> String
    {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let secends = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, secends)
    }
    func getNextPoseData()
    {
        currentPoseIndex += 1
        print(currentPoseIndex)
    }
  
    @objc func timerResults(timer: Timer)
    {
        if indexProgressBar == poseDuration
        {
            getNextPoseData()
            indexProgressBar = 0
        }
        
       progtress_view.progress = Float(indexProgressBar) / Float(poseDuration - 1)
        indexProgressBar += 1
    }
    @IBAction func backcliked(sender: UIButton)
    {
        print("backcliked")
        self.dismiss(animated: true, completion: nil)
    }
}
//MARK: Service call
extension StartChargingVC
{
    func StartChargingOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            print()
            let dataa = getPostData(kUserDefault.object(forKey:"user_id")! as Any as! String, chargeId: str_chargincode , payment: str_charginPaymentID)
            print(dataa)
            let paramDict: Parameters = dataa
            print("parameter",paramDict)
            let manager = Networkmanager()
            manager.StartTransactionWithParam(params: paramDict, completionBlock:
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
             //print("Signupdatadict==",jsonResp)
            
             let dataDict1 = jsonResp.value(forKey: "resType") as! String
              // print("Signupdatadict==",dataDict1)
            
              let status_value = jsonResp.value(forKey: "resId") as! NSNumber
             // print("Signupdatadict==",status_value)
            
            if status_value == 3
            {
                Utils.showAlertWithMessage(message:"Payment Successfull!", onViewController: self)
                        if isTimerRunning == false
                        {
                            runTimer()
                        }
                        getNextPoseData()
                        timer = Timer.scheduledTimer(timeInterval: 1, target:self , selector: #selector(StartChargingVC.timerResults(timer:)), userInfo:nil , repeats:true)
            }
            else
            {
                Utils.showAlertWithMessage(message:"Please try again!", onViewController: self)
            }
        }
    }
    
    func responseFailure(error : Error)
    {
        Utils.dismissProgressHud()
        Utils.showAlertWithMessage(message:"Please try again.!", onViewController: self)
}
}
