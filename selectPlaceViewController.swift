//
//  selectPlaceViewController.swift
//  iDriver
//
//  Created by GaoLi on 14-8-14.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit


/**搜索结果*/
var PlaceArray : NSMutableArray?
/**搜索结果页面*/
var displayController : UISearchDisplayController?
/**记录开始坐标*/
var startLat : Double?
var startLng : Double?


class selectPlaceViewController: UIViewController, AMapSearchDelegate, UISearchBarDelegate,UISearchDisplayDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBAction func backBtn(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    /**搜索框*/
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        AMsearch!.delegate = self
        PlaceArray = NSMutableArray(capacity: 1000)
        self.title = "所在位置"
        
        initDisPlayController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
       
        return PlaceArray!.count
    }
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!{
    
        var cell  : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier:"cell")
        }
       
        var tip : AMapTip = PlaceArray![indexPath.row] as AMapTip
        cell.textLabel.text = tip.name
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!){
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        var tip : AMapTip = PlaceArray![indexPath.row] as AMapTip
        selectPlace = tip.name
        var geoRequest : AMapGeocodeSearchRequest = AMapGeocodeSearchRequest()
        geoRequest.searchType = AMapSearchType_Geocode
        geoRequest.address = selectPlace
        AMsearch!.AMapGeocodeSearch(geoRequest)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func searchTipsWithKey(key : String){
        var tipsRequest : AMapInputTipsSearchRequest = AMapInputTipsSearchRequest()
        tipsRequest.searchType = AMapSearchType_InputTips
        tipsRequest.city = ["上海"]
        tipsRequest.keywords = key
        AMsearch!.AMapInputTipsSearch(tipsRequest)
    }
    
     /**利用高德地图的搜索API搜索*/
    func onInputTipsSearchDone(request: AMapInputTipsSearchRequest!, response: AMapInputTipsSearchResponse!) {
        PlaceArray!.setArray(response.tips)
        displayController!.searchResultsTableView.reloadData()
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        searchTipsWithKey(searchString)
        return true 
    }
    
     func initDisPlayController(){
        
        displayController = UISearchDisplayController(searchBar: self.searchBar, contentsController: self)
        displayController!.searchResultsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        displayController!.delegate = self
        displayController!.searchResultsDataSource = self
        displayController!.searchResultsDelegate = self
    }
    
    //转换成经纬度的代理
    func onGeocodeSearchDone(request: AMapGeocodeSearchRequest!, response: AMapGeocodeSearchResponse!) {
        var geo : AMapGeocode = response.geocodes[0] as AMapGeocode
        startLat = Double(geo.location.latitude)
        startLng = Double(geo.location.longitude)
    }

  
    
  
    
  
    
   

  
}
