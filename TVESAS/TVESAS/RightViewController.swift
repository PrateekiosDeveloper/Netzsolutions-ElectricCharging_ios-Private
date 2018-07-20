//
//  RightViewController.swift
//  
//
//  Created by Ratiocinative Solutions on 17/07/18.
//

import UIKit

class RightViewController: UIViewController, UITableViewDataSource,UITableViewDelegate
{
    
    let arr_Menuitem1 = ["Location", "My Payment", "Information", "Edit Profile" , "Sign Out"]
    let arr_img1 = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "payment"),#imageLiteral(resourceName: "information") , #imageLiteral(resourceName: "editprofile")  , #imageLiteral(resourceName: "soignout")]
    
    
    @IBOutlet weak var tbl_view : UITableView!
    @IBOutlet weak var lbl_Username : UILabel!
    @IBOutlet weak var img_userimage : UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated) // No need for semicolon
        tbl_view.tableFooterView = UIView()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tbl_view.dequeueReusableCell(withIdentifier: "RightViewCell", for: indexPath) as! RightViewCell
        
        cell.lbl_Menuitem.text = arr_Menuitem1[indexPath.row]
        cell.img_Menuitem.image = arr_img1[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  arr_Menuitem1.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if indexPath.row==0
        {
          
        }
        if indexPath.row==1
        {
            let SetPinVCObj = self.storyboard?.instantiateViewController(withIdentifier: "PaymentVC") as? PaymentVC
           self.navigationController?.pushViewController(SetPinVCObj!, animated: true)
        }
        if indexPath.row==2
        {
            let SetPinVCObj = self.storyboard?.instantiateViewController(withIdentifier: "InformationVC") as? InformationVC
           self.navigationController?.pushViewController(SetPinVCObj!, animated: true)
        }
        if indexPath.row==3
        {
            let SetPinVCObj = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
            self.navigationController?.pushViewController(SetPinVCObj!, animated: true)
        }
        if indexPath.row==4
        {
            let alert = UIAlertController(title:"TVESAS", message : "Are you sure you want to Sign out?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"No", style: .default, handler:
                { _ in
                    
            }))
            
            alert.addAction(UIAlertAction(title:"Yes", style: .default, handler:
                { _ in
                    kUserDefault.setValue(false, forKey: kuserLoggedIn);
                    
                    let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.navigationController?.pushViewController(loginobj, animated:false)
                    
                    print("You tapped cell number \(indexPath.row).")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
}

