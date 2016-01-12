//
//  ViewController.swift
//  Where Am I
//  Commented out the depreciated code that no longer works 
//  for others can see what the difference in how to handle
//  location is done as of the latest Xcode & Swift Update
//  Created by Gil Aguilar on 1/11/16.
//  Copyright © 2016 toplevel. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var manager:CLLocationManager!
    
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy - kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        var userLocation:CLLocation = locations[0]
        
        self.latitudeLabel.text = "\(userLocation.coordinate.latitude)"
        
        self.longitudeLabel.text = "\(userLocation.coordinate.longitude)"
        
        self.courseLabel.text = "\(userLocation.course)"
        
        self.speedLabel.text = "\(userLocation.speed)"
        
        self.altitudeLabel.text = "\(userLocation.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            
            if (error != nil) {
                
                print(error)
                
            } else {
                
//                if let p = CLPlacemark(placemark: placemarks?[0] as! CLPlacemark) {
//                    
//                    var subThoroughfare: String = ""
//                    
//                    if (p.subThoroughfare != nil) {
//                        
//                        subThoroughfare = p.subThoroughfare
//                        
//                    }
//                    
//                    self.addressLabel.text = "\(subThoroughfare)\(p.thoroughfare)\n \(p.subLocality)\n  \(p.subAdministrativeArea) \(p.postalCode)\n  \(p.country)"
//                }
                if let p = placemarks?[0] {
                    
                    var subThoroughfare:String = ""
                    
                    if (p.subThoroughfare != nil) {
                        
                        subThoroughfare = p.subThoroughfare!
                        
                    }
                    
                    self.addressLabel.text = "\(subThoroughfare) \(p.thoroughfare) \n \(p.subLocality) \n \(p.subAdministrativeArea) \n \(p.postalCode) \n \(p.country)"
                    
                }

            }
            
        })
        
        
    
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

