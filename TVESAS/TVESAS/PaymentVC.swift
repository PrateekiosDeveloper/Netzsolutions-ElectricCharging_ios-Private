//
//  PaymentVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 20/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class PaymentVC: UIViewController, UITableViewDataSource,UITableViewDelegate
{
    
    let arr_date = ["2018-03-05", "2018-03-07", "2018-03-10", "2018-03-12" , "2018-03-14" , "2018-03-15" , "2018-03-17" , "2018-03-19" , "2018-03-20" , "2018-03-21" , "2018-03-22"]
    let arr_amount = ["100", "500" , "200","1000", "400", "100" , "100" , "100" , "400" , "1000" , "100"]
    let arr_TransactionID = ["123652148523" , "78925164321" , "15265852315" , "784512563215" ,"412513251289" , "711254321589" ,  "485213624581" , "852462152362" , "458219582463" , "485698211584","788545921586"]
    let arr_Location = ["223 Advocate Society" , "Bestech Square Mall, Sector 66, Sahibzada Ajit Singh Nagar, Punjab 160062" , "Forest complex mohali" ,  "Phase 9 mohali" , "Palm meadows Kharar" , "223 Advocate Society" ,"Phase 10 mohali"  , "Forest complex mohali" , "Phase 10 mohali" , "Palm meadows Kharar" , "Bestech Square Mall, Sector 66, Sahibzada Ajit Singh Nagar, Punjab 160062"]
    
    
    
    @IBOutlet weak var tbl_view : UITableView!
    @IBOutlet weak var lbl_Username : UILabel!
    @IBOutlet weak var img_userimage : UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated) 
        tbl_view.tableFooterView = UIView()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbl_view.dequeueReusableCell(withIdentifier: "RightViewCell", for: indexPath) as! RightViewCell
        cell.lbl_Date.text = arr_date[indexPath.row]
        cell.lbl_Amount.text = arr_amount[indexPath.row]
        cell.lbl_Location.text = arr_Location[indexPath.row]
        cell.lbl_TransactionID.text = arr_TransactionID[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arr_date.count
    }
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    }
}

