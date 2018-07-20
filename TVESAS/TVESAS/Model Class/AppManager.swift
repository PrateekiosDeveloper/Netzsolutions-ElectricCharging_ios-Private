//
//  FSManager.swift
//  FastShipping
//
//  Created by ondoor_mac1 on 14/08/17.
//  Copyright © 2017 ondoor_mac1. All rights reserved.
//

import Foundation
import SVProgressHUD


class AppManager: NSObject
{
    static let shared = AppManager()
      var strForDeviceToken = String()
    var dictForStartAndEndDate = NSMutableDictionary()
    
    func showHudWithMask()
    {
        SVProgressHUD.show()
        SVProgressHUD.setDefaultMaskType(.none)
    }
    
    
}
