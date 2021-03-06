//
//  Networkmanager.swift
//  IOU
//
//  Created by Ondoor Concepts Pvt. Ltd. Bhopal on 07/06/17.
//  Copyright © 2017 Ondoor Concepts Pvt. Ltd. Bhopal. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//MARK: Base URL


class Networkmanager: NSObject
{

    var authToken = Utils.getBearerToken()
    typealias CompletionHandler = (_ response:DataResponse<Any>) -> Void
    
   

    //MARK: Login
    func loginWithParam(params paramDict : Parameters, completionBlock :@escaping CompletionHandler)
    {
        let postURL = String(format: "\(kLoginbaseURl)")
        var request = URLRequest(url: URL(string: postURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.setValue("richestLifeAdmin", forHTTPHeaderField: "username")
      //  request.setValue("123456", forHTTPHeaderField: "password")

        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramDict)
        Alamofire.request(request)
            .responseJSON { response in
                completionBlock(response)
        }
    }
   
    
   //MARK: SocialLogin
    
    //MARK: Login
    func loginWithSMSParam(params paramDict : Parameters, completionBlock :@escaping CompletionHandler)
    {
        let postURL = String(format: "\(kSmsapi)")
        var request = URLRequest(url: URL(string: postURL)!)
        request.httpMethod = "POST"
       // request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("richestLifeAdmin", forHTTPHeaderField: "username")
        //  request.setValue("123456", forHTTPHeaderField: "password")
        
      //  request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramDict)
        Alamofire.request(request)
            .responseJSON { response in
                completionBlock(response)
        }
    }
    
    
    func loginWithStationDetailParam(params paramDict : Parameters, completionBlock :@escaping CompletionHandler)
    {
        let postURL = String(format: "\(kAllmachineDetailbaseURl)")
        var request = URLRequest(url: URL(string: postURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("richestLifeAdmin", forHTTPHeaderField: "username")
        //  request.setValue("123456", forHTTPHeaderField: "password")
        
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramDict)
        Alamofire.request(request)
            .responseJSON { response in
                completionBlock(response)
        }
    }
    
    
    func GetchargerDetailWithParam(params paramDict : Parameters, completionBlock :@escaping CompletionHandler)
    {
        let postURL = String(format: "\(kChargerDetailbaseURl)")
        var request = URLRequest(url: URL(string: postURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("richestLifeAdmin", forHTTPHeaderField: "username")
        //  request.setValue("123456", forHTTPHeaderField: "password")
        
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramDict)
        Alamofire.request(request)
            .responseJSON { response in
                completionBlock(response)
        }
    }
    
    func StartTransactionWithParam(params paramDict : Parameters, completionBlock :@escaping CompletionHandler)
    {
        let postURL = String(format: "\(kActionTransactionbaseURl)")
        var request = URLRequest(url: URL(string: postURL)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("richestLifeAdmin", forHTTPHeaderField: "username")
        //  request.setValue("123456", forHTTPHeaderField: "password")
        
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.httpBody = try! JSONSerialization.data(withJSONObject: paramDict)
        Alamofire.request(request)
            .responseJSON { response in
                completionBlock(response)
        }
    }
    
 
    
}
