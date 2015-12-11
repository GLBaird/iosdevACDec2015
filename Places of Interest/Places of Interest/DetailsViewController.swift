//
//  DetailsViewController.swift
//  Places of Interest
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import Social

class DetailsViewController: ToolbarViewController {
    
    // outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var place:Place?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let place = self.place {
            dateLabel.text = "Visited on \(place.longDate)"
            descriptionText.text = place.placeDescription
            imageView.image = place.image
            navigationItem.title = place.placeName
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let map = segue.destinationViewController as! MapViewController
        map.place = place
    }

    // MARK: - Action Methods
    
    @IBAction func postToSocial(sender: UIBarButtonItem) {
        let socail = SLComposeViewController(
            forServiceType: sender.tag == 0
                ? SLServiceTypeFacebook
                : SLServiceTypeTwitter
        )
        
        socail.setInitialText("I visited \(place!.placeName!) on \(place!.shortDate)")
        socail.addImage(place?.image)
        
        presentViewController(socail, animated: true, completion: nil)
    }
    

}
