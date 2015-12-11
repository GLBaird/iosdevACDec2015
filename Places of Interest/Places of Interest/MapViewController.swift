//
//  MapViewController.swift
//  Places of Interest
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: ToolbarViewController {
    
    var place:Place?
    
    @IBOutlet weak var map:MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if let place = self.place {
            
            map.addAnnotation(place)
            
            map.setRegion(
                MKCoordinateRegion(
                    center: place.coordinate,
                    span: MKCoordinateSpan(
                        latitudeDelta: 0.05,
                        longitudeDelta: 0.05
                    )
                ),
                animated: true
            )
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Action Methods
    
    @IBAction func changeMapType(sender:UIBarButtonItem) {
        map.mapType = MKMapType(rawValue: UInt(sender.tag))!
    }
    
}
