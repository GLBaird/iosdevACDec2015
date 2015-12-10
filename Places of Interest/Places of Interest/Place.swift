//
//  Place.swift
//  Places of Interest
//
//  Created by Leon Baird on 10/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreData

let PlaceEntityName = "Place"
let PlaceAttributeName = "placeName"
let PlaceAttributeDate = "dateVisited"

class Place: NSManagedObject {

    var longDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: .LongStyle,
            timeStyle: .NoStyle
        )
    }
    
    var shortDate:String {
        return NSDateFormatter.localizedStringFromDate(
            NSDate(timeIntervalSince1970: dateVisited),
            dateStyle: .ShortStyle,
            timeStyle: .NoStyle
        )
    }
    
    var image:UIImage? {
        return UIImage(contentsOfFile: NSHomeDirectory() + imagePath!)
    }
    
    func removeImageFromDisk() {
        do {
            if !imagePath!.isEmpty {
                try NSFileManager.defaultManager().removeItemAtPath(NSHomeDirectory() + imagePath!)
            }
        } catch {}
    }

}



