//
//  ViewController.swift
//  Networking
//
//  Created by Trainer on 13/11/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let jsonURL = NSURL(string: "http://leonbaird.co.uk/iphone/userdata.json")!
        let jsonData = NSData(contentsOfURL: jsonURL)!
        do {
            let parsedData = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
            print("Json Data :\(parsedData)")
            let name = parsedData["users"]!![0]["name"] as! String
            print("The name is \(name)")
        } catch {
            print("Failed to parse")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func syncDownload(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
       
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        let imageData = NSData(contentsOfURL: imageURL)
        let imageView = UIImageView(image: UIImage(data: imageData!))
        
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    @IBAction func asyncDownload(sender: AnyObject) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        let imageURL = NSURL(string: "http://leonbaird.co.uk/iphone/large.jpg")!
        
        let backgroundQ = dispatch_queue_create("DownloadImage", nil)
        dispatch_async(backgroundQ) {
            let imageData = NSData(contentsOfURL: imageURL)
            dispatch_async(dispatch_get_main_queue(), {
                let imageView = UIImageView(image: UIImage(data: imageData!))
                
                self.scrollView.addSubview(imageView)
                self.scrollView.contentSize = imageView.frame.size
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            })
        }
        
    }
}

