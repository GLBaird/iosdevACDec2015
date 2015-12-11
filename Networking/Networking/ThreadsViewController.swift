//
//  ThreadsViewController.swift
//  Networking
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ThreadsViewController: UIViewController {
    
    // outlets
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func foreground(sender: AnyObject) {
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        if let imageData = NSData(contentsOfURL: imageURL) {
            
            let imageView = UIImageView(image: UIImage(data: imageData))
            scrollView.addSubview(imageView)
            scrollView.contentSize = imageView.image!.size
            
        } else {
            print("Failed to download image")
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false

    }
    
    @IBAction func background(sender: AnyObject) {
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // make thread and run async
        let background = dispatch_queue_create("Download Image", nil)
        dispatch_async(background) { () -> Void in
            // working on background thread
            let imageData = NSData(contentsOfURL: imageURL)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // working back on main thread
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                
                if imageData != nil {
                    
                    let imageView = UIImageView(image: UIImage(data: imageData!))
                    self.scrollView.addSubview(imageView)
                    self.scrollView.contentSize = imageView.image!.size
                    
                } else {
                    print("Failed to download image")
                }

            })
        }
        
    }

}
