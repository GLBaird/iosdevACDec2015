//
//  AddPlaceViewController.swift
//  Places of Interest
//
//  Created by Leon Baird on 10/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class AddPlaceViewController: ToolbarViewController,
        UIActionSheetDelegate, UIImagePickerControllerDelegate,
        UINavigationControllerDelegate, CLLocationManagerDelegate {
    
    // outlets
    
    @IBOutlet weak var placeTitle:UITextField!
    @IBOutlet weak var placeDescription:UITextView!
    @IBOutlet weak var imagePreview:UIImageView!
    
    // location details
    lazy var locationManager:CLLocationManager = {
        let locman = CLLocationManager()
        locman.distanceFilter = 10
        locman.delegate = self
        return locman
    }()
    
    var location:CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()

        // handle keyboard appearing
        NSNotificationCenter.defaultCenter().addObserverForName(
            UIKeyboardWillShowNotification,
            object: nil,
            queue: nil) { (notice) -> Void in
                if self.navigationItem.rightBarButtonItem == nil {
                    // create done button and display in navigation bar
                    let done = UIBarButtonItem(
                        barButtonSystemItem: .Done,
                        target: self,
                        action: "closeKeyboard:"
                    )
                    
                    self.navigationItem.setRightBarButtonItem(done, animated: true)
                }
        }
        
        // setup location services
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 8.0, *) {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
        } else {
            showAlert(
                title: "Location Services disabled",
                message: "We need to plot your position on a map, so please activate location services",
                button: "Cancel",
                viewController: self
            )
            
            navigationController?.popViewControllerAnimated(true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - Action methods
    
    func closeKeyboard(sender:AnyObject) {
        placeTitle.resignFirstResponder()
        placeDescription.resignFirstResponder()
        navigationItem.setRightBarButtonItem(nil, animated: true)
    }
    
    @IBAction func clearForm(sender:AnyObject) {
        placeTitle.text = ""
        placeDescription.text = ""
        imagePreview.image = nil
    }
    
    @IBAction func save(sender:AnyObject) {
        let newPlace = NSEntityDescription.insertNewObjectForEntityForName(PlaceEntityName,
            inManagedObjectContext: AppDelegate.getContext()) as! Place
        newPlace.placeName = placeTitle.text
        newPlace.placeDescription = placeDescription.text
        newPlace.dateVisited = NSDate().timeIntervalSince1970
        newPlace.imagePath = ""
        
        if let location = self.location {
            newPlace.geoLat = location.coordinate.latitude
            newPlace.geoLong = location.coordinate.longitude
        }
        
        if let image = imagePreview.image {
            let filename = "/Documents/image_\(newPlace.dateVisited).jpg"
            if let imageData = UIImageJPEGRepresentation(image, 1.0) {
                if imageData.writeToFile(NSHomeDirectory() + filename, atomically: true) {
                    newPlace.imagePath = filename
                }
            }
        }
        
        AppDelegate.getDelegate().saveContext()
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func pickImageSource(sender:AnyObject) {
        if #available(iOS 8.0, *) {
            let choice = UIAlertController(
                title: "Pick image source",
                message: "Choose the source of your image:",
                preferredStyle: .ActionSheet
            )
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                choice.addAction(UIAlertAction(title: "Camera", style: .Default, handler: showImagePicker))
            }
            
            choice.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: showImagePicker))
            choice.addAction(UIAlertAction(title: "Camera Roll", style: .Default, handler: showImagePicker))
            
            choice.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            
            presentViewController(choice, animated: true, completion: nil)
            
            
        } else {
            // Fallback on earlier versions
            let choice = UIActionSheet(
                title: "Pick image source:",
                delegate: self,
                cancelButtonTitle: "Cancel",
                destructiveButtonTitle: nil,
                otherButtonTitles: "Camera", "Photo Library", "Camera Roll"
            )
            
            choice.showInView(view)
        }
    }
    
    // MARK: - Handle choice for camera soruce
    
    @available(iOS 8.0, *)
    func showImagePicker(action:UIAlertAction) {
        switch action.title! {
            case "Camera":
                showImagePickerUI(.Camera)
            case "Photo Library":
                showImagePickerUI(.PhotoLibrary)
            default:
                showImagePickerUI(.SavedPhotosAlbum)
        }
    }
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
            case 1:
                if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    showImagePickerUI(.Camera)
                } else {
                    showAlert(title: "Device Error", message: "Camera is not available on your device", button: "Cancel", viewController: self)
                }
            case 2:
                showImagePickerUI(.PhotoLibrary)
            case 3:
                showImagePickerUI(.SavedPhotosAlbum)
            default:
                break
        }
    }
    
    func showImagePickerUI(source:UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    // MARK: - Image Picker Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePreview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Location Manager Delegate Methods
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        print("Location Found: \(location)")
    }
    

}







