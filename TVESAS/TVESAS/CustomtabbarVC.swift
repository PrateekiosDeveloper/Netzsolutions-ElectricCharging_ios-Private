//
//  CustomtabbarVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class CustomtabbarVC: UITabBarController,SWRevealViewControllerDelegate
{
    @IBOutlet weak var homeTabBar: UITabBar!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = nil
        tabBar.clipsToBounds = true
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.title = nil
    }
  
    
    func revealController()
    {
        if self.revealViewController() != nil
        {
            if(revealViewController().frontViewPosition == FrontViewPosition.right)
            {
                revealViewController().frontViewPosition = FrontViewPosition.left
            }
        }
        
    }

    
    // UITabBarDelegate
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
    {
        if item.tag == 1
        {
        }
        
        if item.tag == 2
        {
           
          
            
        }
        if item.tag == 3
        {
        }
        if item.tag == 4
        {
            dismiss(animated: true, completion: nil)
            if revealViewController() != nil
            {
                self.revealViewController().rightViewRevealWidth = 280
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                self.revealViewController().rightRevealToggle(self)
            }
        }
    }
  
        
        
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        
        if viewController is CustomtabbarVC
        {
            print("last tab")
        }
        
        if viewController is CustomtabbarVC
        {
            print("First tab")
        }
        else if viewController is CustomtabbarVC
        {
            print("Second tab")
        }
    }
        
    
}
