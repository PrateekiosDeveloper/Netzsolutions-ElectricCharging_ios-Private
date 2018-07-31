//
//  Constant.swift
//  Frutomental
//
//  Created by Ondoor Concepts Pvt. Ltd. Bhopal on 19/07/17.
//  Copyright © 2017 Ondoor Concepts Pvt. Ltd. Bhopal. All rights reserved.
//

import Foundation
import UIKit

let UD = UserDefaults.standard
let NC = NotificationCenter.default
let applicationDelegate = UIApplication.shared.delegate as! AppDelegate
//MARK:-- NotificationCenter :--
extension Notification.Name {
    static let checkEmptyField = Notification.Name("checkEmptyField")
    static let showTabBar = Notification.Name("showTabBar.with.selected.tab")
    static let restaurantlist = Notification.Name("Restaurant.List")
}

let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
let appDelegate = UIApplication.shared.delegate as! AppDelegate

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let STATUS_BAR_HEIGHT = UIApplication.shared.statusBarFrame.size.height

let SCREEN_MAX_LENGTH    = max(SCREEN_WIDTH, SCREEN_HEIGHT)
let SCREEN_MIN_LENGTH    = min(SCREEN_WIDTH, SCREEN_HEIGHT)

let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH < 568.0
let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && SCREEN_MAX_LENGTH == 812.0
let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && SCREEN_MAX_LENGTH == 1024.0


let kDEVICE = "IOS"

//MARK: Messages
let NoInternetMsg = "Please check internet connctivity & try again."
let failureTitleMessage = "Something went wrong.\n Please try again after sometime."

let Email = "email"
let Password = "password"
let ConfirmPassword = "confirmpassword"
let Action = "action"
let DeviceName = "deviceType"
let DeviceToken = "deviceToken"
let UserName = "username"
let Socialid = "socialId"
let UserID = "userId"
let OldPassword = "oldPassword"
let NewPassword = "newPassword"
let Signup = "signup"
let Login  =  "login"
let Forget  = "forget"
let ChangePassword = "ChangePassword"
let Lottery = "lottery"
let Ticket = "tikets"
let PostId = "postId"

let UserContact = "phone"
let ChangeProfile = "changeProfile"
let SendEmail = "sendEmail"
let Subject = "subject"
let Name = "name"
let Message = "message"


//UserDefault
let userDefault = UserDefaults.standard
let USER_DEFAULT_USERTYPESTR = "USERTYPESTR"
let USER_DEFAULT_USERID_KEY = "userId"
let USER_DEFAULT_POSTID_KEY = "userId"
let USER_DEFAULT_NAME = "name"





func getTimeFormat(milliseconds:Float) -> String
{
    let date = Date(timeIntervalSince1970: (TimeInterval(milliseconds)))
    let datesDifference = getDateDifference(currentDate: date, endDate: Date())
    
    let minutes = datesDifference.minutes
    let hours = datesDifference.hours
    let days = datesDifference.days
    
    if days == 0
    {
        if hours < 1
        {
            return "\(minutes) min ago"
        }
        else {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm a"
            let dateString = formatter.string(from: date)
            return dateString
        }
    }
    else
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let dateString = formatter.string(from: date)
        return dateString
    }
}

func getDateDifference(currentDate:Date, endDate:Date) -> (minutes: Int, hours:Int, days: Int)
{
    let components = Set<Calendar.Component>([.minute, .hour, .day])
    let dateComponents = Calendar.current.dateComponents(components, from: currentDate, to: endDate)
    
    let minutes = dateComponents.minute ?? 0
    let hours = dateComponents.hour ?? 0
    let days = dateComponents.day ?? 0
    print(minutes, hours, days)
    return (minutes, hours, days)
}







let PKMEnterName = "enter_name"
let PKMEnterMobile = "enter_mobile_number"
let PKMSelectGender = "select_gender"
let PKMEnterPassword = "enter_password"
let PKMPasswordLength = "password_length"
let kuserLoggedIn = "userLoggedIn"
let kAuthToken = "device_token"
let kSuccess = ""
let kStatus = "status"
let kMessage = "message"
let kData = "data"
let kUserLoginDict = "UserDict"

let kLoginbaseURl = "http://zeroguess.net/010/chargingMachine/server/actionUser.php"
let kSmsapi = "http://priority.thesmsworld.com/api.php"

let kAllmachineDetailbaseURl = "http://zeroguess.net/010/chargingMachine/server/actionMachineStation.php"
let kActivitybaseURl = "http://zeroguess.net/008/lottd/server/activity.php"
let kChargerDetailbaseURl = "http://zeroguess.net/010/chargingMachine/server/actionMachineStation.php"
let kActionTransactionbaseURl = "http://www.zeroguess.net/010/chargingMachine/server/actionTransaction.php"



let kMethodLogin = "login"
let kUserDefault = UserDefaults.standard
let kApiToken = "api_token"
//MARK: Messages
let kNoInternetMsg = "Please check internet connctivity & try again."
let PKWentWrong = "went_wrong"
