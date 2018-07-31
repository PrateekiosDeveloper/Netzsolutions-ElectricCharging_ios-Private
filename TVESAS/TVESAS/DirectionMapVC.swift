//
//  DirectionMapVC.swift
//  TVESAS
//
//  Created by Ratiocinative Solutions on 25/07/18.
//  Copyright © 2018 Ratiocinative Solutions. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import Alamofire
import SwiftyJSON

class DirectionMapVC: UIViewController , GMSMapViewDelegate
{
    
    @IBOutlet weak var mapkitView: GMSMapView!
    
    var str_CS_SDestinationLat =  CLLocationDegrees()
    var str_CS_SDestinationLong =  CLLocationDegrees()
    
    var str_CS_SCestinationLat =  CLLocationDegrees()
    var str_CS_SCestinationLong =  CLLocationDegrees()
    
  var str_CS_currentlocationname =  String()
      var str_CS_Destinationlocationname =  String()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        
        print("DESTINATION2 LAT", str_CS_SDestinationLat)
        print("DESTINATION2", str_CS_SDestinationLong)
        print("CURRENTLAT LAT", str_CS_SCestinationLat)
        print("CURRENTLONG", str_CS_SCestinationLong)
        
        //        let path = GMSMutablePath()
        //        path.add(CLLocationCoordinate2D(latitude: 30.676586245722, longitude: 76.7397309783402))
        //        path.add(CLLocationCoordinate2D(latitude: 30.695089, longitude: 76.735456))
        //
        //        let rectangle = GMSPolyline(path: path)
        //        rectangle.map = mapkitView
        
        //getPolylineRoute(from:CLLocationCoordinate2D(latitude: 30.676586245722, longitude: 76.7397309783402) , to: CLLocationCoordinate2D(latitude: 30.695089, longitude: 76.735456))
        
        
        //GMSServices.provideAPIKey("AIzaSyC907BQBnrZK0UjA2zARtE6Mq7L__yqw5Q")
        // GMSPlacesClient.provideAPIKey("AIzaSyC907BQBnrZK0UjA2zARtE6Mq7L__yqw5Q")
        
        
        // Create a GMSCameraPosition that tells the map to display the
        
        let camera = GMSCameraPosition.camera(withLatitude: str_CS_SCestinationLat,
                                              longitude: str_CS_SCestinationLong,
                                              zoom: 10.0,
                                              bearing: 30,
                                              viewingAngle: 40)
        //Setting the googleView
        self.mapkitView.camera = camera
        self.mapkitView.delegate = self
        self.mapkitView?.isMyLocationEnabled = true
        self.mapkitView.settings.myLocationButton = true
        self.mapkitView.settings.compassButton = true
        self.mapkitView.settings.zoomGestures = true
        self.mapkitView.animate(to: camera)
        self.view.addSubview(self.mapkitView)
        
        //Setting the start and end location
        let origin = "\(28.524555),\(77.275111)"
        let destination = "\(28.643091),\(77.218280)"
        
        //  let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=\(origin)&destination=\(destination)&mode=driving,NY&key="""
        
        // let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
        
        
        
        
        let url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.6905615%2C-73.9976592%7C40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626%7C40.659569%2C-73.933783%7C40.729029%2C-73.851524%7C40.6860072%2C-73.6334271%7C40.598566%2C-73.7527626&key= AIzaSyBvrCwuehY8SuHzLzm60ziXNCB5ehXpXRs"
        
        
       
            Alamofire.request(url).responseJSON{
            response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result)   // result of response serialization
            
            let path = GMSMutablePath()
                path.add(CLLocationCoordinate2D(latitude: self.str_CS_SCestinationLat, longitude: self.str_CS_SCestinationLong))
                path.add(CLLocationCoordinate2D(latitude: self.str_CS_SDestinationLat, longitude: self.str_CS_SCestinationLong))
            
            let polyline = GMSPolyline.init(path: path)
            polyline.strokeColor = UIColor.blue
            polyline.strokeWidth = 2
            polyline.map = self.mapkitView
        }
        
     
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: str_CS_SCestinationLat, longitude: str_CS_SCestinationLong)
        marker.title = str_CS_currentlocationname
       // marker.snippet = "India"
        marker.map = mapkitView
        
        
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: str_CS_SDestinationLat, longitude: str_CS_SCestinationLong)
        marker1.title = str_CS_Destinationlocationname
        //marker1.snippet = "India"
        marker1.map = mapkitView
        
    }
    @IBAction func backcliked(sender: UIButton)
    {
      self.navigationController?.popViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
