//
//  Functions.swift
//  Places of Interest
//
//  Created by Leon Baird on 10/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit


// Function for showing alerts
func showAlert(title title:String?, message:String?, button:String, viewController:UIViewController) {
    
    if #available(iOS 8.0, *) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .Alert
        )
        
        alert.addAction(
            UIAlertAction(
                title: button,
                style: .Cancel,
                handler: nil
            )
        )
        
        viewController.presentViewController(alert, animated: true, completion: nil)
        
    } else {
        // Fallback on earlier versions
        let alert = UIAlertView(
            title: title,
            message: message,
            delegate: nil,
            cancelButtonTitle: button
        )
        
        alert.show()
    }
    
}

