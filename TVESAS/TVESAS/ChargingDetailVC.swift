//
//  ChargingDetailVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 24/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import AVFoundation
import BarcodeScanner
import SwiftyJSON
import CoreLocation

class ChargingDetailVC: UIViewController , UITextFieldDelegate , CLLocationManagerDelegate
{
    
    @IBOutlet weak var view_payment : UIView!
    @IBOutlet weak var view_chargerID : UIView!
    @IBOutlet weak var txt_chargerID : UITextField!
    
    
    @IBOutlet weak var lbl_Address : UILabel!
    @IBOutlet weak var lbl_Distance : UILabel!
    @IBOutlet weak var lbl_WorKingStatus : UILabel!
    @IBOutlet weak var lbl_KWLevel : UILabel!
    @IBOutlet weak var lbl_StationCode : UILabel!
    @IBOutlet weak var lbl_ConnectorTypeName : UILabel!
    
      var str_locationname = String()
    var str_distence = Double()
    var str_capacity = String()
    var str_ChargerTypeName = String()
    var str_CS_machine_name =  String()
    var str_CS_machineChargingStationCode = String()
    var str_CS_address =  String()
    var str_CS_MachineStatus =  String()
    
    
     var str_CS_DestinationLat =  CLLocationDegrees()
     var str_CS_DestinationLong =  CLLocationDegrees()
    
    
    
    var str_CS_CestinationLat =  CLLocationDegrees()
    var str_CS_CestinationLong =  CLLocationDegrees()
    
    let locationManager = CLLocationManager()
    
    
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
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        
    
        
        
        
        
        str_capacity += "kw"
        lbl_KWLevel.text = str_capacity
        lbl_Address.text = str_CS_address
        lbl_ConnectorTypeName.text = str_ChargerTypeName
        lbl_WorKingStatus.text = str_CS_MachineStatus
        lbl_StationCode.text = str_CS_machineChargingStationCode
        
        print("str_distence",str_distence)
        lbl_Distance.text = String(format: "%.2fkm", str_distence)
        
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    @IBAction func Bookchargingbuttonclick(_sender : UIButton)
    {
        view_payment.isHidden = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        
        str_CS_CestinationLat = userLocation.coordinate.latitude
         str_CS_CestinationLong = userLocation.coordinate.longitude
        
        
        print("CURRENTLAT LAT", str_CS_CestinationLat)
        print("CURRENTLONG", str_CS_CestinationLong)
        
        
        
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            
            
            // Location name
            let locationName = placeMark.name
            print("location name",locationName!)
            
            
            // Street address
            let sublocality = placeMark.subLocality
            print("sublocality",sublocality!)
            
            
            let locality = placeMark.locality
            print("locality",locality!)
            
            // Country
            let country = placeMark.country
            print("country",country!)
            
            
           // self.lbl_mylocation.text  =  String(format: "%@,%@,%@,%@",sublocality! , locality! , locationName! , country!)
            
            self.str_locationname = String(format: "%@,%@,%@,%@",sublocality! , locality! , locationName! , country!)
          //  SVProgressHUD .dismiss()
            self.locationManager.stopUpdatingLocation()
            
        })
    }
    

    
    
    @IBAction func MapButtonclick(_sender : UIButton)
    {
        print("country1",str_CS_DestinationLat)
        print("country2",str_CS_DestinationLong)
        print("country3",str_CS_CestinationLat)
         print("country4",str_CS_CestinationLong)
        
        
        
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "DirectionMapVC") as? DirectionMapVC
        
        EditProfileVCObj?.str_CS_SDestinationLat = str_CS_DestinationLat
        EditProfileVCObj?.str_CS_SDestinationLong = str_CS_DestinationLong
        EditProfileVCObj?.str_CS_SCestinationLat = str_CS_CestinationLat
        EditProfileVCObj?.str_CS_SCestinationLong = str_CS_CestinationLong
        EditProfileVCObj?.str_CS_currentlocationname =   self.str_locationname
        EditProfileVCObj?.str_CS_Destinationlocationname =   str_CS_address
        
        self.navigationController?.pushViewController(EditProfileVCObj!, animated: true)
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
    
    @IBAction func ScanQRcodeclicked(_sender : UIButton)
    {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self as? BarcodeScannerErrorDelegate
        viewController.dismissalDelegate = self as? BarcodeScannerDismissalDelegate
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func Donebuttonclick(_sender : UIButton)
    {
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingAmountVC") as? ChargingAmountVC
        EditProfileVCObj?.str_chargingcode = txt_chargerID.text!
        self.present(EditProfileVCObj!, animated: true, completion: nil)
    }
    
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {   
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backbuttonclick(_sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
}
extension ChargingDetailVC: BarcodeScannerCodeDelegate
{
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String)
    {
        print("Barcode Data: \(code)")
        print("Symbology Type: \(type)")
        
        controller.dismiss(animated: true, completion: nil)
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingAmountVC") as? ChargingAmountVC
         EditProfileVCObj?.str_chargingcode = code
        self.present(EditProfileVCObj!, animated: true, completion: nil)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error)
    {
        print(error)
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingAmountVC") as? ChargingAmountVC
        self.navigationController?.pushViewController(EditProfileVCObj!, animated: true)
    }
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerViewController)
    {
        controller.dismiss(animated: true, completion: nil)
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingAmountVC") as? ChargingAmountVC
        self.navigationController?.pushViewController(EditProfileVCObj!, animated: true)
    }
}
extension ViewController: BarcodeScannerDismissalDelegate
{
    func scannerDidDismiss(_ controller: BarcodeScannerViewController)
    {
        
        controller.dismiss(animated: true, completion: nil)
        let EditProfileVCObj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingAmountVC") as? ChargingAmountVC
        self.navigationController?.pushViewController(EditProfileVCObj!, animated: true)
    }
}
