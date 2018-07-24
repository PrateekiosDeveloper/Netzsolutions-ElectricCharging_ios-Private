//
//  ChargingDetailVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 24/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class ChargingDetailVC: UIViewController,UITextFieldDelegate
{

     @IBOutlet weak var view_payment : UIView!
     @IBOutlet weak var view_chargerID : UIView!
     @IBOutlet weak var txt_chargerID : UITextField!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       view_payment.isHidden = true
         view_chargerID.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        view_payment.isHidden = true
        view_chargerID.isHidden = true
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func Bookchargingbuttonclick(_sender : UIButton)
    {
       view_payment.isHidden = false
    }
    @IBAction func cancelbuttonclick(_sender : UIButton)
    {
        view_payment.isHidden = true
        view_chargerID.isHidden = true
    }
    @IBAction func EnterChargerIDButtonclick(_sender : UIButton)
    {
        view_chargerID.isHidden = false
        view_payment.isHidden = true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {   //delegate method
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
