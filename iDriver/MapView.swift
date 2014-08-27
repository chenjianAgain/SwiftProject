//
//  MapView.swift
//  iDriver
//
//  Created by Gao  Li on 14/7/24.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit
import MapKit



/**定义位置管理器*/
let manager = CLLocationManager()
/**标识当前位置*/
var loc : CLLocationCoordinate2D?
/**添加地图*/
var map : MAMapView?
var a : DriverAnnotation?

///**记录半颗星的起始位置*/
//var halfStarRect : CGRect?
///**记录空心的起始位置*/
//var emptyStarRect : CGRect?
///**用于放置半颗星*/
//var halfStar : UIImageView?




class MapView: UIView, MAMapViewDelegate,CLLocationManagerDelegate {
  
    func createMap() {
        MAMapServices.sharedServices().apiKey = "1fe713f6719276dd0fd593e67326ae5c"
        map = MAMapView(frame: self.bounds)
        map!.mapType = MAMapType.Standard
        map!.showsUserLocation = true
        map!.zoomEnabled = true
        map!.scrollEnabled = true
        map!.delegate = self
        map!.zoomLevel = 5
        map!.showsCompass = false
        map!.showsScale = false
        self.addSubview(map!)
        
        
        /**创建位置管理器*/
        if CLLocationManager.locationServicesEnabled(){
            manager.delegate = self
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.distanceFilter = 100.0
            manager.startUpdatingLocation()
        }
        /**获取当前位置，当无法获取时，给个默认值*/
        loc  = CLLocationCoordinate2DMake(31.1695, 121.388)
       // loc  = CLLocationCoordinate2DMake(31.1713562731702, 121.383629178524)
        if manager.location {
            loc = manager.location.coordinate
        }
        var userSpan : MACoordinateSpan = MACoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var region : MACoordinateRegion = MACoordinateRegionMake(loc!, userSpan)
        map!.region = region

    }
    /**定位更新时的回调函数*/
    func mapView(mapView: MAMapView!, didUpdateUserLocation userLocation: MAUserLocation!, updatingLocation: Bool) {
        loc = manager.location.coordinate
    }
    
    func createDriverView(driverDic : NSMutableDictionary) -> UIView{
        var array : NSArray = NSBundle.mainBundle().loadNibNamed("DriverCell", owner: self, options: nil)
        var driverCell : DriverCell = array.objectAtIndex(0) as DriverCell
        driverCell.driverNameLabel!.text = driverDic["name"] as NSString
        driverCell.driverNumberLabel!.text = driverDic["no"] as String
        driverCell.driverPhoto!.image = driverDic["pic"] as UIImage
        driverCell.layer.cornerRadius = 10
        var grade : Float = driverDic["grade"].floatValue
        StarUtil.showDriverStar(grade, view: driverCell.starView!)

        return driverCell
    }

    
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(DriverAnnotation){
            a = annotation as? DriverAnnotation
            var view : MAAnnotationView?
            
            view = mapView.dequeueReusableAnnotationViewWithIdentifier(a!.driver["no"] as String)
            if view == nil{
                view = MAAnnotationView(annotation: annotation, reuseIdentifier: a!.driver["no"] as String)
                var str : String = a!.driver["no"] as String
        
                var subView : UIView = createDriverView(a!.driver)
                 view!.addSubview(subView)
                var rect : CGRect = subView.frame
                view!.frame = rect
                subView.frame = rect
                /**添加手势*/
                var tapGR : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "driverCellClick:")
                subView.addGestureRecognizer(tapGR)
                
            }
            
            return view
        }
       return nil
    }
    
    func driverCellClick(t : UITapGestureRecognizer){
        var subView : DriverCell = t.view as DriverCell
        var driverNumber : String = subView.driverNumberLabel!.text as String
        var cen : NSNotificationCenter = NSNotificationCenter.defaultCenter()
        cen.postNotificationName("driverInfo", object: driverNumber)
    }
    
   
    
        
    
}
