//
//  EditProfileVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 18/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class EditProfileVC: UIViewController , UITextFieldDelegate
{

    @IBOutlet weak var btn_update : UIButton!
    
    @IBOutlet weak var txt_Username : UITextField!
    @IBOutlet weak var txt_Password : UITextField!
    @IBOutlet weak var txt_Contactno : UITextField!
    @IBOutlet weak var txt_Profileimage : UITextField!
     @IBOutlet weak var txt_Location : UITextField!
      @IBOutlet weak var img_profileimage : UIImageView!
    
    
    var chosenImage : UIImage?

    override func viewDidLoad()
    {
        super.viewDidLoad()
     

    }
    @IBAction func selectProfilePicture(_ sender: Any)
    {
        ShowCamera()
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        if textField == txt_Profileimage
        {
            txt_Username .becomeFirstResponder()
        }
        if textField == txt_Username
        {
            txt_Contactno.becomeFirstResponder()
        }
        if textField == txt_Contactno
        {
            txt_Location.becomeFirstResponder()
        }
        if textField == txt_Location
        {
            txt_Password.becomeFirstResponder()
        }
        if textField == txt_Password
        {
            textField.resignFirstResponder()
        }
        return true
    }

    @IBAction func Updateclicked(_sender : UIButton)
    {
           Utils.showProgressHud()
            callupdate_WS()
    }
    func callupdate_WS()
    {
        Utils.showProgressHud()
        EditProfileOnServer()
    }
    
    func nextscreen ()
    {
        Utils.showAlertWithMessage(message: "Profile Update  Successfully!", onViewController: self)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    //Mark- Show Camera Function
    @objc func ShowCamera()
    {
        let alert = UIAlertController(title:"ChooseImage", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Camera", style: .default, handler:
            { _ in
                self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title:"Gallery", style: .default, handler:
            { _ in
                self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title:"cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- ImagePickerFromCamera
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(.camera))
        {
            let img_picker = UIImagePickerController()
            img_picker.delegate = self
            img_picker.sourceType = .camera
            img_picker.showsCameraControls = true
            present(img_picker, animated: true, completion: nil)
        }
        else
        {
            Utils.showAlertWithMessage(message: "This device has no Camera!", onViewController: self)
        }
    }
    
    //MARK: -ImgePickerFromGallery
    func openGallary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
}
//MARK: Service call
extension EditProfileVC
{
    func EditProfileOnServer()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
      
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            let base64String11 = convertImageTobase64(format: .png, image: chosenImage!)
            
            
            let paramDict: Parameters = ["task": "editUser" ,  "user_id":kUserDefault.object(forKey:"user_id")! as Any , "first_name":txt_Username.text! , "contact_no": txt_Contactno.text! ,
                                         "address":txt_Location.text! , "password": txt_Password.text! , "user_image": base64String11!, "image_name": "test.png",   "device_type": "ios",  "userTimeZone" : localTimeZoneNamee ]


            let manager = Networkmanager()
            manager.loginWithParam(params: paramDict, completionBlock:
                { (response) in
                    print("\(response)")

                    switch response.result
                    {
                    case .success:
                        self.successfullReceivedResponse(response: response)
                    case .failure(let error):
                        self.responseFailure(error: error)
                    }
            })
        }
        else
        {
            Utils.showAlertWithMessage(message: kNoInternetMsg, onViewController: self)
        }
    }
    func imageOrientation(_ src:UIImage)->UIImage
    {
        if src.imageOrientation == UIImageOrientation.up
        {
            return src
        }
        var transform: CGAffineTransform = CGAffineTransform.identity
        switch src.imageOrientation
        {
        case UIImageOrientation.down, UIImageOrientation.downMirrored:
            transform = transform.translatedBy(x: src.size.width, y: src.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
            break
        case UIImageOrientation.left, UIImageOrientation.leftMirrored:
            transform = transform.translatedBy(x: src.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
            break
        case UIImageOrientation.right, UIImageOrientation.rightMirrored:
            transform = transform.translatedBy(x: 0, y: src.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
            break
        case UIImageOrientation.up, UIImageOrientation.upMirrored:
            break
        }
        
        switch src.imageOrientation {
        case UIImageOrientation.upMirrored, UIImageOrientation.downMirrored:
            transform.translatedBy(x: src.size.width, y: 0)
            transform.scaledBy(x: -1, y: 1)
            break
        case UIImageOrientation.leftMirrored, UIImageOrientation.rightMirrored:
            transform.translatedBy(x: src.size.height, y: 0)
            transform.scaledBy(x: -1, y: 1)
        case UIImageOrientation.up, UIImageOrientation.down, UIImageOrientation.left, UIImageOrientation.right:
            break
        }
        
        let ctx:CGContext = CGContext(data: nil, width: Int(src.size.width), height: Int(src.size.height), bitsPerComponent: (src.cgImage)!.bitsPerComponent, bytesPerRow: 0, space: (src.cgImage)!.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.concatenate(transform)
        
        switch src.imageOrientation {
        case UIImageOrientation.left, UIImageOrientation.leftMirrored, UIImageOrientation.right, UIImageOrientation.rightMirrored:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.height, height: src.size.width))
            break
        default:
            ctx.draw(src.cgImage!, in: CGRect(x: 0, y: 0, width: src.size.width, height: src.size.height))
            break
        }
        
        let cgimg:CGImage = ctx.makeImage()!
        let img:UIImage = UIImage(cgImage: cgimg)
        
        return img
    }
    public enum ImageFormat
    {
        case png
        case jpeg(CGFloat)
    }
    
    
    func convertImageTobase64(format: ImageFormat, image:UIImage) -> String?
    {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImagePNGRepresentation(image)
        case .jpeg(let compression): imageData = UIImageJPEGRepresentation(image, compression)
        }
        return imageData?.base64EncodedString()
    }
    func successfullReceivedResponse(response: DataResponse<Any>)
    {

        Utils.dismissProgressHud()
        if let result = response.result.value
        {
            let jsonResp = result as! NSDictionary
            
            var statusmessage = String()
            statusmessage = jsonResp.value(forKey:"status_message") as! String
            
            if(Utils.returnStringFor(value: jsonResp.value(forKey: kStatus)) == "200")
            {
                if let dataDict = jsonResp.value(forKey: kData) as? NSDictionary
                {
                    
                    
                    let str_userid =  dataDict["user_id"] as? String
              
                    
                    
               
                    
                    
                    
                    kUserDefault.setValue(str_userid, forKey:"user_id");
                   
                    kUserDefault.setValue(txt_Username.text?.capitalized, forKey:"UserName");
                    kUserDefault.setValue(txt_Contactno.text, forKey:"UserMobile");
                    kUserDefault.setValue(txt_Location.text, forKey:"Usercity");
                    
                    
                    
                    let str_image =  dataDict["user_image"] as? String
                   kUserDefault.setValue(str_image, forKey:"UserImage");
                    
                    
                    
                    let alert = UIAlertController(title:"TVESAS", message:statusmessage, preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title:"Ok", style: .default, handler:
                        { _ in
                            self.navigationController?.popViewController(animated: true)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            }
            else
            {
                Utils.showAlertWithMessage(message:statusmessage, onViewController: self)
            }
        }
    }
    
    func responseFailure(error : Error)
    {
        Utils.dismissProgressHud()
        Utils.showAlertWithMessage(message:"Please try again.!", onViewController: self)
    }
}
extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        chosenImage = self.imageOrientation(chosenImage!)
   
      
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}




