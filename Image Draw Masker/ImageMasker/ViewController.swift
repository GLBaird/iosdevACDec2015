//
//  ViewController.swift
//  ImageMasker
//
//  Created by Leon Baird on 15/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // outlets
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var maskView: DrawingMaskView!
    
    var pickedImage:UIImage?
    var maskedImage:UIImage?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        maskView.userInteractionEnabled = false;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func pickImage(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func clearMask(sender: AnyObject) {
        maskView.clearMask()
    }

    @IBAction func saveMask(sender: AnyObject) {
        if let image = pickedImage {
            maskView.maskImage(image)
            imagePreview.image = nil
        }
    }
    
    // UIImagePicker Controller Delegate methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        imagePreview.image = pickedImage
        maskedImage = nil
        dismissViewControllerAnimated(true, completion: nil)
        maskView.userInteractionEnabled = true
    }
    
}

