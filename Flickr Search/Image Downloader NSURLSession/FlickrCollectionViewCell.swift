//
//  FlickrCollectionViewCell.swift
//  Image Downloader NSURLSession
//
//  Created by Leon Baird on 12/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class FlickrCollectionViewCell: UICollectionViewCell {
    
    var cellID:String!
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var photoNameLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    func registerCellID() -> String {
        cellID = NSUUID().UUIDString
        return cellID
    }

}
