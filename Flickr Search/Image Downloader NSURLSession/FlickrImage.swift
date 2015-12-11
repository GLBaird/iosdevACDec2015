//
//  FlickrImages.swift
//  Image Downloader NSURLSession
//
//  Created by Leon Baird on 12/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

enum FlickrImageType {
    case Thumb, Full
}

class FlickrImage {
    
    var name:String
    var thumbURL:NSURL
    var fullURL:NSURL
    
    private var cached:String?
    
    var isCached:Bool {
        return cached != nil
    }
    
    init(name:String, thumbURL:String, fullURL:String) {
        self.name     = name
        self.thumbURL = NSURL(string: thumbURL)!
        self.fullURL  = NSURL(string: fullURL)!
    }
    
    init(name:String, thumbURL:NSURL, fullURL:NSURL) {
        self.name     = name
        self.thumbURL = thumbURL
        self.fullURL  = fullURL
    }
    
    private func getCachedImage() -> UIImage? {
        if let path = cached {
            return UIImage(contentsOfFile: NSHomeDirectory() + path)
        }
        
        return nil
    }
    
    func getImage(type:FlickrImageType, callBack:(image:UIImage?)->Void) {
        if type == FlickrImageType.Thumb && isCached {
            if let image = getCachedImage() {
                callBack(image: image)
                return
            }
        }
        
        let thread = dispatch_queue_create("image", nil)
        let url = type == FlickrImageType.Full ? fullURL : thumbURL
        dispatch_async(thread, {
            let imageData = NSData(contentsOfURL: url)
            dispatch_async(dispatch_get_main_queue(), {
                if imageData != nil {
                    if type == FlickrImageType.Thumb {
                        // cache image
                        var name = NSUUID().UUIDString
                        name = "/tmp/\(name).dat"
                        if imageData!.writeToFile(NSHomeDirectory()+name, atomically: true) {
                            self.cached = name
                            print("Image cached: \(name)")
                        }
                    }
                    if let image = UIImage(data: imageData!) {
                        callBack(image: image)
                    } else {
                        self.cached = nil
                        callBack(image: nil)
                        print("Failed to parse image data from download: \(url)")
                    }
                } else {
                    print("Failed to download image \(url)")
                    callBack(image: nil)
                }
            })
        })
    }
    
}
