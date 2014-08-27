//
//  DriverAnnotation.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/23.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
import MapKit

class DriverAnnotation: NSObject, MAAnnotation {
 
    var coordinate: CLLocationCoordinate2D
    var driver : NSMutableDictionary
    
    func setCoordinate(newCoordinate: CLLocationCoordinate2D){
        self.coordinate = newCoordinate
    }
   
    init(driver: NSMutableDictionary) {
        self.driver = driver
        self.coordinate = CLLocationCoordinate2D(latitude: self.driver["lat"].doubleValue, longitude: self.driver["lng"].doubleValue)
    }
    
}
