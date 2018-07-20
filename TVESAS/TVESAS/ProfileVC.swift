//
//  ProfileVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 18/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileVC: UIViewController
{
    @IBOutlet weak var btn_EditProfile : UIButton!
     @IBOutlet weak var lbl_Username : UILabel!
     @IBOutlet weak var lbl_Location : UILabel!
     @IBOutlet weak var lbl_Contactno : UILabel!
     @IBOutlet weak var lbl_FirstFullName : UILabel!
     @IBOutlet weak var img_profile : UIImageView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        lbl_Location.text =    kUserDefault.value(forKey:"Usercity") as? String
        lbl_Username.text =   kUserDefault.value(forKey:"UserName") as? String
        lbl_Contactno.text =   kUserDefault.value(forKey:"UserMobile") as? String
        lbl_FirstFullName.text =   kUserDefault.value(forKey:"UserName") as? String
        
         
         let  user_image_str =  kUserDefault.value(forKey:"UserImage") as? String
        
        print("naamtosuna",kUserDefault.value(forKey:"UserImage")!)
        print("naamtonhisuna",kUserDefault.value(forKey:"img_profileimage")!)
        
   
        
        if user_image_str == nil
        {
            img_profile.image = UIImage(named:"emptyimage.png")
        }
        else
        {
            if user_image_str == "http://zeroguess.net/010/chargingMachine/userimages/"
            {
                img_profile.image = UIImage(named:"emptyimage.png")
            }
            else
            {
             img_profile.sd_setImage(with: URL(string:user_image_str!), placeholderImage: UIImage(named:"emptyimage.png"))
            }
        }
        
        
        
        
      
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func EditProfileClicked(_sender : UIButton)
    {
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") as? EditProfileVC
        self.navigationController?.pushViewController(EditProfileVCObj!, animated: true)
    }
    
}
