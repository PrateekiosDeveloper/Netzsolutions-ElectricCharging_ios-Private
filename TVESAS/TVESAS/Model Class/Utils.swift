//
//  Utils.swift
//  Frutomental
//
//  Created by Ondoor Concepts Pvt. Ltd. Bhopal on 19/07/17.
//  Copyright © 2017 Ondoor Concepts Pvt. Ltd. Bhopal. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

import SVProgressHUD

enum AlertAction : Int
{
    case OK = 0
    case Cancel
}

class Utils: NSObject
{
    
    typealias CompletionHandler = () -> Void
    typealias completionHandler = (_ alertAction:AlertAction) -> Void
    
  
    
    static func getBearerToken()-> String
    {
        var authToken = ""
        if let userLoginDict = kUserDefault.value(forKey: kUserLoginDict) as? NSDictionary
        {
            if let tempAuthToken = userLoginDict.value(forKey: kApiToken) as? String
            {
                authToken = tempAuthToken
            }
        }
        
        return "Bearer "+authToken
    }
    
    static func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
    
    //MARK: HUD
    static func showProgressHud()
    {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        DispatchQueue.main.async(execute: {
            SVProgressHUD.show()
        })
    }
    static func dismissProgressHud()
    {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
        })
    }
    
    static func moveToHome(_ showProfile: Bool = false)
    {

    }
    
   
    static func showAlertWithMessage(message msgStr: String, onViewController controller: UIViewController)
    {
        //let appname = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let alert = UIAlertController(title:"TVESAS", message: msgStr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithMessage(_ message: String, onViewController controller: UIViewController,handler completionBlock :@escaping CompletionHandler)
    {
        //let appname = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let alert = UIAlertController(title: "TVESAS", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            completionBlock()
        }
        alert.addAction(alertAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertMessage(_ message: String, onViewController controller: UIViewController,handler completionBlock :@escaping completionHandler)
    {
        //let appname = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let alert = UIAlertController(title: "TVESAS", message: message, preferredStyle: .alert)
        let alertOkay = UIAlertAction(title: "OK", style: .default) { (action) in
            completionBlock(.OK)
        }
        alert.addAction(alertOkay)
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completionBlock(.Cancel)
        }
        alert.addAction(alertCancel)
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertWithMessageAndTitle(alert alertTitle: String,message msgStr: String, onViewController controller: UIViewController)
    {
        let alert = UIAlertController(title: alertTitle, message: msgStr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(alertAction)
        controller.present(alert, animated: true, completion: nil)
    }
    static func returnStringFor(value:Any?) -> String
    {
        if(value is NSNull)
        {
            return ""
        } else if(value == nil) {
            return ""
        } else if(value is String) {
            return (value as? String) ?? ""
        }else{
            return "\(value ?? "")"
        }
    }
    
    static func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    {
        URLSession.shared.dataTask(with: url)
        {
            data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    static func showanimationwithdurationforHidden(message childview: UIView)
    {
        
        UIView.transition(with: childview, duration: 0.5, options: .transitionCrossDissolve, animations:
            {
                childview.isHidden = true
            })
        
    }
    
    static func showanimationwithdurationforSHow(message childview: UIView)
    {
        
        UIView.transition(with: childview, duration: 0.5, options: .transitionCrossDissolve, animations:
            {
                childview.isHidden = false
        })
        
    }
}

