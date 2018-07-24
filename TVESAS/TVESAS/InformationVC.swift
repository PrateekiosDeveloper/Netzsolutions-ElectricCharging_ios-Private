//
//  InformationVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 20/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SVProgressHUD
class InformationVC: UIViewController,UIWebViewDelegate
{
   @IBOutlet weak var web_view : UIWebView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
        let url = NSURL (string: "http://zeroguess.net/006/evc/")
       let requestObj = URLRequest(url: url! as URL)
        web_view.loadRequest(requestObj)
         
     }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        SVProgressHUD .dismiss()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        }
    
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }


}
