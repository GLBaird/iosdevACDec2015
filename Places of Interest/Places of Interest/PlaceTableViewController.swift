//
//  PlaceTableViewController.swift
//  Places of Interest
//
//  Created by Leon Baird on 10/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData

class PlaceTableViewController: UITableViewController {
    
    lazy var places:NSFetchedResultsController! = {
        
        let request = NSFetchRequest(entityName: PlaceEntityName)
        request.sortDescriptors = [
            NSSortDescriptor(key: PlaceAttributeDate, ascending: false),
            NSSortDescriptor(key: PlaceAttributeName, ascending: true)
        ]
        
        let resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.getContext(),
            sectionNameKeyPath: nil,
            cacheName: "Places"
        )
        
        // on iPad become the delegate
        
        return resultsController
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try places.performFetch()
        } catch {
            showAlert(title: "Database Error", message: "Cannot load places", button: "OK", viewController: self)
            places = nil
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if places != nil && places.sections != nil {
            return places.sections!.count
        }
        
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.sections![section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlaceCell", forIndexPath: indexPath) as! PlaceCell
        let place = places.objectAtIndexPath(indexPath) as! Place
        

        // Configure the cell...
        
        cell.placeName.text = place.placeName
        cell.placeDate.text = place.shortDate
        if place.imagePath!.isEmpty {
            cell.placeImage.contentMode = .Center
            cell.placeImage.image = UIImage(named: "Camera")
        } else {
            cell.placeImage.image = place.image
            cell.placeImage.contentMode = .ScaleAspectFill
        }

        return cell
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            let place = places.objectAtIndexPath(indexPath) as! Place
            place.removeImageFromDisk()
            AppDelegate.getContext().deleteObject(place)
            AppDelegate.getDelegate().saveContext()
            do {
                try places.performFetch()
            } catch {}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let place = places.objectAtIndexPath(tableView.indexPathForSelectedRow!) as! Place
        let details = segue.destinationViewController as! DetailsViewController
        details.place = place
        
    }
    

}
