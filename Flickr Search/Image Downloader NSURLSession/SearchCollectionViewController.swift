//
//  SearchCollectionViewController.swift
//  Image Downloader NSURLSession
//
//  Created by Leon Baird on 12/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

private let cellIdentifier = "preview"

class SearchCollectionViewController: UICollectionViewController, UISearchBarDelegate {

    var photos:[FlickrImage]!
    
    var searchBar:UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // add search bar
        searchBar = UISearchBar(
            frame: CGRect(x: 0.0, y: 62.0, width: view.bounds.width, height: 50.0)
        )
        searchBar.autoresizingMask = [.FlexibleWidth, .FlexibleLeftMargin, .FlexibleRightMargin]
        view.addSubview(searchBar)
        
        // setup search bar
        searchBar.placeholder = "Search Flickr Images"
        searchBar.showsCancelButton = true
        searchBar.autocapitalizationType = .None
        searchBar.autocorrectionType = .Yes
        searchBar.spellCheckingType = .No
        
        searchBar.delegate = self
        
        // setup collection view
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(
            width: UIScreen.mainScreen().bounds.width/3.02,
            height: UIScreen.mainScreen().bounds.width/3.02 * 1.26
        )
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        collectionView?.setCollectionViewLayout(layout, animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if let detailVC = segue.destinationViewController as? DetailViewController {
            let index = collectionView!.indexPathsForSelectedItems()!.last!
            detailVC.image = photos[index.row]
        }
    }
    
    // MARK: - Action Methods
    
    
    @IBAction func clearSearch(sender: AnyObject) {
        if !searching {
            searchBar.text = nil
            searchBar.resignFirstResponder()
            photos = nil
            if collectionView?.numberOfSections() > 0 {
                UIView.beginAnimations("removeSearch", context: nil)
                UIView.setAnimationDuration(0.8)
                collectionView?.deleteSections(NSIndexSet(index: 0))
                UIView.commitAnimations()
            }
        }
    }

    // MARK: - UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // one or two sections as first section is header with search
        return photos == nil ? 0 : 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  photos.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        // get cell and image ref from collection
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! FlickrCollectionViewCell
        let image = photos[indexPath.row]
        
        // Configure the cell
        cell.photoNameLabel.text = image.name
        
        // setup for animation if needing to download image
        cell.imagePreview.image = nil
        
        if !image.isCached {
            cell.imagePreview.alpha = 0.0
            cell.photoNameLabel.alpha = 0.0
            cell.backgroundColor = UIColor.clearColor()
            cell.spinner.startAnimating()
            cell.spinner.alpha = 1.0
        } else {
            cell.imagePreview.alpha = 1.0
            cell.spinner.stopAnimating()
            cell.spinner.alpha = 0.0
        }
        
        let cellID = cell.registerCellID()
        
        image.getImage(FlickrImageType.Thumb, callBack: {
            image in
            
            // display image
            if cell.cellID == cellID {
                cell.imagePreview.image = image
                
                // animate image onto screen
                if cell.imagePreview.alpha == 0.0 {
                    cell.spinner.stopAnimating()
                    UIView.beginAnimations("showCell", context: nil)
                    UIView.setAnimationCurve(.EaseIn)
                    UIView.setAnimationDuration(1.0)
                    cell.spinner.alpha = 0.0
                    cell.imagePreview.alpha = 1.0
                    cell.photoNameLabel.alpha = 1.0
                    cell.backgroundColor = UIColor.whiteColor()
                    UIView.commitAnimations()
                }
            }
        })
        
        return cell
    }
    
    
    // MARK: - Search Bar Delegate Methods
    
    var searching = false
    var flickr = FlickrDownloader()
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searching = true
        print("Starting")
        flickr.searchImages(
            searchBar.text!, completion: {
                images, error in

                self.searching = false

                // check for error and show alert
                if error != nil && images == nil {
                    let alert = UIAlertController(
                        title: "Network Error",
                        message: "Error searching Flickr!\nReason: \(error!.localizedDescription)",
                        preferredStyle: UIAlertControllerStyle.Alert
                    )
                    alert.addAction(
                        UIAlertAction(
                            title: "OK",
                            style: .Cancel,
                            handler: nil
                        )
                    )
                    self.presentViewController(alert, animated: true, completion: nil)
                    return
                }
                
                // update array and reload table
                self.photos = images
                self.collectionView?.reloadData()
                
        })
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        return !searching
    }

}
