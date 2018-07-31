//
//  HomeViewController.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 17/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps
import CoreLocation

class HomeViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate
{
    var dataDict = NSArray()
    var arr_CSid = NSArray()
    var arr_chargtypeName = NSArray ()
    var arr_CS_machine_name = NSArray()
    var arr_CSname = NSArray()
    var arr_address = NSArray()
    var arr_CSlat = NSArray()
    var arr_CSlong = NSArray()
    var arr_CS_machineStatus = NSArray()
    var locationManager = CLLocationManager()
    var arr_ChargerCapacity = NSArray()
    var  arr_ChargerTypeName = NSArray()
    var   arr_CS_machineChargingStationCode = NSArray()
    var str_currentLat = CLLocationDegrees()
    var str_currentLong = CLLocationDegrees()
    var str_lat =   CLLocationDegrees()
    var str_long = CLLocationDegrees()
    
   
    
    
    @IBOutlet weak var mapkitView: GMSMapView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestAlwaysAuthorization()
        LocationwebServerice()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error while updating location " + error.localizedDescription)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
     
        
        print("str_currentLat",str_currentLat)
        print("str_currentLong",str_currentLong)
        
        
        str_currentLat = locValue.latitude
        str_currentLong = locValue.longitude
        
        
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        
        let index:Int! = Int(marker.accessibilityLabel!)
        
   
        
        let latitude = (arr_CSlat[index]as! NSString).doubleValue
        let longitude = (arr_CSlong[index] as! NSString).doubleValue
        
    
        
        let myLocation = CLLocation(latitude: str_currentLat , longitude: str_currentLong)
        let myBuddysLocation = CLLocation(latitude: latitude , longitude: longitude)
        
        let distance = myLocation.distance(from: myBuddysLocation) / 1000
        print(String(format: "The distance to my buddy is %.01fkm", distance))
        
        
          print("DESTINATION LAT", arr_CSlat[index])
             print("DESTINATIONLONG", arr_CSlong[index])
     
        
       let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingDetailVC") as! ChargingDetailVC
        loginobj.str_CS_address  = arr_address[index] as! String
        loginobj.str_capacity = arr_ChargerCapacity[index] as! String
        loginobj.str_ChargerTypeName = arr_ChargerTypeName[index] as! String
        loginobj.str_CS_MachineStatus = arr_CS_machineStatus[index] as! String
        loginobj.str_CS_machineChargingStationCode =   arr_CS_machineChargingStationCode[index] as! String
        loginobj.str_distence = distance
        loginobj.str_CS_DestinationLat = latitude
        loginobj.str_CS_DestinationLong = longitude
        
        self.navigationController?.pushViewController(loginobj, animated:false)
        
    }
    
    //    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    //    {
    //        print("title2",marker.title!)
    //        print("title4",marker.userData!)
    //        let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingDetailVC") as! ChargingDetailVC
    //        self.navigationController?.pushViewController(loginobj, animated:false)
    //
    //        return true
    //    }
}
//MARK: Service call
extension HomeViewController
{
    func LocationwebServerice()
    {
        if(Utils.isConnectedToInternet())
        {
            Utils.showProgressHud()
            
            var localTimeZoneNamee: String{ return TimeZone.current.identifier}
            
            
            let paramDict: Parameters = ["task": "getAllMachinesStations",
                                         "device_type": "ios",
                                         "device_key": "65e4f0ad0030bc6117b44cad741a0ad5984351aa",
                                         "userTimeZone" : localTimeZoneNamee]
            
            
            let manager = Networkmanager()
            manager.loginWithStationDetailParam(params: paramDict, completionBlock:
                { (response) in
                    
                    
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
    func successfullReceivedResponse(response: DataResponse<Any>)
    {
        Utils.dismissProgressHud()
        if let result = response.result.value
        {
            let jsonResp = result as! NSDictionary
            
            var statusmessage = String()
            statusmessage = jsonResp.value(forKey:"status_message") as! String
            
            let status = jsonResp.value(forKey:"status") as! Int
            
            if status == 200
            {
                
                dataDict = (jsonResp.value(forKey: "data")) as! NSArray
                arr_CSid = (dataDict.value(forKey: "charging_station_id") as? NSArray)!
                arr_chargtypeName = (dataDict.value(forKey: "charger_type_name") as? NSArray)!
                arr_CSname = (dataDict.value(forKey: "charging_station_name") as? NSArray)!
                arr_address = (dataDict.value(forKey: "address") as? NSArray)!
                arr_CSlat = (dataDict.value(forKey: "latitude") as? NSArray)!
                arr_CSlong = (dataDict.value(forKey: "longitude") as? NSArray)!
                arr_ChargerCapacity = (dataDict.value(forKey: "kwh_level") as? NSArray)!
                arr_ChargerTypeName = (dataDict.value(forKey: "connector_type_name") as? NSArray)!
                arr_CS_machine_name = (dataDict.value(forKey: "charging_station_machine_name") as? NSArray)!
                arr_CS_machineChargingStationCode = (dataDict.value(forKey: "machine_charging_station_code") as? NSArray)!
                arr_CS_machineStatus = (dataDict.value(forKey: "machine_status") as? NSArray)!
                print("Signupdatadict==",dataDict)
            
                for i in 0..<arr_CSlat.count
                {
                    
                    let latitudes = (arr_CSlat[i] as! NSString).doubleValue
                    let longitudes = (arr_CSlong[i]  as! NSString).doubleValue
                    
                    let coordinates = CLLocationCoordinate2D(latitude:latitudes, longitude:longitudes)
                    let marker = GMSMarker(position: coordinates)
                    marker.title = arr_CSname[i] as? String
                    marker.snippet = arr_address[i] as? String
                    marker.accessibilityLabel = "\(i)"
                    let markerImage = UIImage(named: "electric_car_charging_icon_black.png")!
                    
                    let markerView = UIImageView(image: markerImage)
                    markerView.contentMode = .scaleAspectFit
                    marker.iconView = markerView
                    markerView.tintColor = UIColor.red
                    
                    marker.isTappable = true
                    
                    let sydney = GMSCameraPosition.camera(withLatitude: latitudes,
                                                          longitude: longitudes,
                                                          zoom: 6)
                    mapkitView.camera = sydney
                    marker.map = mapkitView
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
    
    func  moveToHome()
    {
        let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(loginobj, animated:false)
    }
}

