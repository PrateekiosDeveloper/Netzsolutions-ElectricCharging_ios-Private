//
//  DetailVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 18/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, UITableViewDataSource,UITableViewDelegate
{
    
  //  let arr_Menuitem1 = ["Location", "My Payment", "Information", "Edit Profile" , "Sign Out"]
//    let arr_img1 = [#imageLiteral(resourceName: "location"),#imageLiteral(resourceName: "payment"),#imageLiteral(resourceName: "information") , #imageLiteral(resourceName: "editprofile")  , #imageLiteral(resourceName: "soignout")]
    
    
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
        
  //      cell.lbl_Menuitem.text = arr_Menuitem1[indexPath.row]
      //  cell.img_Menuitem.image = arr_img1[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
      
    }
}

