//
//  RightViewCell.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 18/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell
{
     @IBOutlet weak var lbl_Menuitem : UILabel!
     @IBOutlet weak var img_Menuitem : UIImageView!
     @IBOutlet weak var lbl_Date: UILabel!
     @IBOutlet weak var lbl_Location : UILabel!
     @IBOutlet weak var lbl_Amount : UILabel!
     @IBOutlet weak var lbl_TransactionID : UILabel!
   
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
   }

}
