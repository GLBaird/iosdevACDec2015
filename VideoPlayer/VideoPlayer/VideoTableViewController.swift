//
//  VideoTableViewController.swift
//  VideoPlayer
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoTableViewController: UITableViewController {
    
    var videoPaths = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // load video file names from foler "videos" in bundle
        let videoFolderPath = NSBundle.mainBundle().pathForResource("videos", ofType: nil)!
        do {
            videoPaths = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(videoFolderPath)
        } catch {
            let alert = UIAlertController(title: "File Error", message: "Cannot read video files", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videoPaths.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell", forIndexPath: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = videoPaths[indexPath.row]

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // setup video for video player
        let videoFile = videoPaths[tableView.indexPathForSelectedRow!.row]
        let videoDetails = videoFile.componentsSeparatedByString(".")
        let videoPlayerController = segue.destinationViewController as! AVPlayerViewController
        
        videoPlayerController.title = videoFile
        if let videoURL = NSBundle.mainBundle().URLForResource(videoDetails[0], withExtension: videoDetails[1], subdirectory: "videos") {
            videoPlayerController.player = AVPlayer(URL: videoURL)
            videoPlayerController.player?.play()
        } else {
            let alert = UIAlertController(title: "File Error", message: "Cannot read video files", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }

    }

}
