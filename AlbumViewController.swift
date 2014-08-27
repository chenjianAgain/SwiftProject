//
//  AlbumViewController.swift
//  iDriver
//
//  Created by tp on 14-8-15.
//  Copyright (c) 2014年 Gao  Li. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {

    
        
    @IBOutlet weak var albumTableView: UITableView!
    
    //table的cell及其上的控件
    var albumCell: PhotoTableViewCell = PhotoTableViewCell()
    var toDetailPhoto: UIImageView = UIImageView()
    var albumName: UILabel = UILabel()
    var photoNumber: UILabel = UILabel()
    var stringToInt : Int = 0
   
    //选择哪一行伸缩
    var hiddenSectionIndex : Int = 0
    
    //控制伸缩的bool值
    var shouldHidden : Bool = false
    
    //collection的cell
    var cell : PhotoCollectionViewCell = PhotoCollectionViewCell()
    
    
    //照片的数量
    var photoNum : Int = 0
    
    
    
    //调用基本方法的变量
    var un : Until = Until()
    
    
    
    
    @IBAction func dismissVC(sender: UIButton) {
    
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //albumCell.photoCollection = UICollectionView(frame: CGRectMake(0, 50, 320, 250), collectionViewLayout: UICollectionViewFlowLayout())
        
        hiddenSectionIndex = -1
        
        un.photoArrMethod()
        
        println("tmd\(un.photoArrMethod())")
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
   /**UITableViewDelegate and DataSource*/
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        
        return  1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        
        albumCell = albumTableView.dequeueReusableCellWithIdentifier("albumCell", forIndexPath: indexPath) as PhotoTableViewCell
        if albumCell == nil {
            
            albumCell = PhotoTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
        }
        
        
        toDetailPhoto.removeFromSuperview()
        albumName.removeFromSuperview()
        photoNumber.removeFromSuperview()
        //albumCell.contentView.removeFromSuperview()
        
        
        toDetailPhoto = UIImageView(frame: CGRectMake(15, 17, 16, 16))
        albumName = UILabel(frame: CGRectMake(43, 14, 68, 21))
        photoNumber = UILabel(frame: CGRectMake(274, 14, 24, 21))
        
        
        photoNumber.text = "11"
        stringToInt = (photoNumber.text as NSString).integerValue
        
        albumName.text = "高清相册"
        
        if shouldHidden{
            
            toDetailPhoto.image = UIImage(named: "photo_arrow_unfold.png")
        }
        else{
        
            toDetailPhoto.image = UIImage(named: "photo_arrow_fold.png")
        }
        
        albumCell.contentView.addSubview(toDetailPhoto)
        albumCell.contentView.addSubview(albumName)
        albumCell.contentView.addSubview(photoNumber)
        
        
        shouldHidden = (indexPath.row == hiddenSectionIndex) ? true : false
        
        albumCell.photoCollection.frame.size.height = shouldHidden ? (un.heightForAlbum(stringToInt)) : 0
        
        
        return albumCell
    }

    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        
        shouldHidden = (indexPath.row == hiddenSectionIndex) ? true : false
        
        var collectionHeight = shouldHidden ? (un.heightForAlbum(stringToInt)) : 0
        
        return shouldHidden ? 50 + collectionHeight : 50
        
    }
    
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        
        
        
        if hiddenSectionIndex == indexPath.row{
            
            hiddenSectionIndex = -1
            
            albumTableView.reloadData()
            
            return
        }
        
        hiddenSectionIndex = indexPath.row
        
        albumTableView.reloadData()
    }

    
    
    func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        
        return 1
    }

    
    /**UICollectionViewDelegate and DataSource*/
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        
        //真实数据为该相册的照片数量
        return stringToInt
    }
    
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        
        
        cell = albumCell.photoCollection.dequeueReusableCellWithReuseIdentifier("photo", forIndexPath: indexPath) as PhotoCollectionViewCell
        
       
        
        
        println(un.photoArrMethod())
        //真实数据为该相册的照片，如果遍历出来的相片是分组的，这里的写法应该改成按照最外层数组索引取出并拨开字典键值对的方式，给对应的tableCell分配数据
        
        //cell.photoImgView.image = un.photoArrMethod()[indexPath.item] as UIImage
        
        
        return cell
    }
    
    
    
    //传值
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        
        if (segue.identifier as NSString).isEqualToString("showDetail"){
        
    //判断点击的是哪个图片
            var selectIndexPath : NSIndexPath = ((albumCell.photoCollection.indexPathsForSelectedItems())as NSArray).objectAtIndex(0) as NSIndexPath
            
            var photoIndex : Int = selectIndexPath.item
            
            
            var detailVC : DetailPhotoViewController = segue.destinationViewController as DetailPhotoViewController
            
            
            //detailImg = un.photoArrMethod()[photoIndex] as UIImage
        }
    }
    

}
