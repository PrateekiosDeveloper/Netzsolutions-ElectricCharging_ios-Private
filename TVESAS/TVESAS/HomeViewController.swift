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

class HomeViewController: UIViewController,GMSMapViewDelegate
{
    var dataDict = NSArray()
    var arr_CSid = NSArray()
    var arr_chargtypeName = NSArray ()
    var arr_CS_machine_name = NSArray()
    var arr_CSname = NSArray()
    var arr_address = NSArray()
    var arr_CSlat = NSArray()
    var arr_CSlong = NSArray()
    
  
    
    
    
    @IBOutlet weak var mapkitView: GMSMapView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        LocationwebServerice()
    }
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        print("title1",marker.title!)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        print("title2",marker.title!)
        let loginobj = self.storyboard?.instantiateViewController(withIdentifier: "ChargingDetailVC") as! ChargingDetailVC
        self.navigationController?.pushViewController(loginobj, animated:false)
        
        return true
    }
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
            
            //print("parameter",paramDict)
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
                arr_CS_machine_name = (dataDict.value(forKey: "charging_station_machine_name") as? NSArray)!
                arr_CSname = (dataDict.value(forKey: "charging_station_name") as? NSArray)!
                arr_address = (dataDict.value(forKey: "address") as? NSArray)!
                
                arr_CSlat = (dataDict.value(forKey: "latitude") as? NSArray)!
                arr_CSlong = (dataDict.value(forKey: "longitude") as? NSArray)!
                
                print("Signupdatadict==",dataDict)
                //                print("arr_CSid==",arr_CSid)
                //                print("arr_chargtypeName==",arr_chargtypeName)
                //                print("arr_CS_machine_name==",arr_CS_machine_name)
                //                print("arr_CSname==",arr_CSname)
                //                print("arr_address==",arr_address)
                //                print("arr_CSlat==",arr_CSlat)
                //                print("arr_CSlong==",arr_CSlong)
                
                
                for i in 0..<arr_CSlat.count
                {
                    
                    let latitudes = (arr_CSlat[i] as! NSString).doubleValue
                    let longitudes = (arr_CSlong[i]  as! NSString).doubleValue
                    
                    let coordinates = CLLocationCoordinate2D(latitude:latitudes, longitude:longitudes)
                    let marker = GMSMarker(position: coordinates)
                    marker.title = arr_CSname[i] as? String
                    marker.snippet = arr_address[i] as? String
                    
                    let markerImage = UIImage(named: "electric_car_charging_icon_black.png")!
                    
                    let markerView = UIImageView(image: markerImage)
                    markerView.contentMode = .scaleAspectFit
                    marker.iconView = markerView
                    markerView.tintColor = UIColor.red
                    marker.isTappable = true
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

