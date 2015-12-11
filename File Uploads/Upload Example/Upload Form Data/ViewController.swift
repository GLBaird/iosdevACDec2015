//
//  ViewController.swift
//  Upload Form Data
//
//  Created by Leon Baird on 19/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

// check this URL to see the Post request received:
//      http://leonbaird.co.uk/iphone/output.txt
// check this URL to see uploaded files:
//      http://leonbaird.co.uk/iphone/uploads


import UIKit

// MARK: Enumerator for package type

enum PackageType: Int {
    case Cheap, Ok, Gold
    
    var serverCode: String {
        switch self {
        case .Cheap:
            return "CP400"
        case .Ok:
            return "OK400"
        case .Gold:
            return "GD101"
        }
    }
}

// MARK: -

class ViewController: UIViewController,
        UITextFieldDelegate,
        UIImagePickerControllerDelegate,
        UINavigationControllerDelegate,
        NSURLSessionDelegate,
        NSURLSessionDataDelegate,
        NSURLSessionTaskDelegate
{
    
    // MARK: outlets
    @IBOutlet weak var surnameTF:UITextField!
    @IBOutlet weak var forenameTF:UITextField!
    @IBOutlet weak var emailTF:UITextField!
    @IBOutlet weak var contactSwitch:UISwitch!
    @IBOutlet weak var serviceType:UISegmentedControl!
    @IBOutlet weak var imagePreview:UIImageView!
    @IBOutlet weak var resultLog:UITextView!
    
    @IBOutlet var textFields: [UITextField]!

    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make surname first responder
        surnameTF.becomeFirstResponder()
        
        // setup log
        resultLog.text = "** Ready to send form data **"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func postFormData(sender:UIButton) {
        if !validateForm() {
            let alert = UIAlertController(title: "Form Error", message: "You may have an incomplete form or a malformed email. Please complete form correctly and pick an image.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // close keyboard if visible
        for tf in textFields { tf.resignFirstResponder() }
        
        // build data model
        // NOTE: I am sending data as JSON which means server side code is different
        // from normal parsing of URL Encoded data!
        // create a URL encoded string and use that as data instead - 
        // default header Content-Type for URLRequest is url-encoded form data
        var form = Dictionary<String, AnyObject>()
        for tf in textFields { form[tf.placeholder!] = tf.text }
        form["contact"] = contactSwitch.selected
        form["serviceType"] = PackageType(rawValue: serviceType.selectedSegmentIndex)!.serverCode
        
        // To encode as URL Variables
//        let urlComponent = NSURLComponents(string: "http://leonbaird.co.uk/iphone/input.php")!
//        urlComponent.queryItems = [
//            NSURLQueryItem(name: "surname", value: surnameTF.text),
//            NSURLQueryItem(name: "forename", value: forenameTF.text),
//            NSURLQueryItem(name: "email", value: emailTF.text),
//            NSURLQueryItem(name: "contact", value: contactSwitch.selected ? "YES" : "NO"),
//            NSURLQueryItem(name: "serviceType", value: PackageType(rawValue: serviceType.selectedSegmentIndex)!.serverCode)
//        ]
        
//        let getURLWithVariables = urlComponent.URL!         // http://leonbaird.co.uk?surname=Baird&forename=Leon ... etc
//        let postEncodedURLVariables = urlComponent.query!   // surname=Baird&forename=Leon ... etc
//        let formData = postEncodedURLVariables.dataUsingEncoding(NSUTF8StringEncoding)
        
        do {
            let formData = try NSJSONSerialization.dataWithJSONObject(form, options: .PrettyPrinted)
            
            // JSON Formed:
            resultLog.text! += "JSON Ready to send:\n"+String(data: formData, encoding: NSUTF8StringEncoding)!
            
            // URL Encoded Data:
//            resultLog.text! += "URLEncoded data ready to send:\n\(postEncodedURLVariables)"
            
            // Make request
            let serviceURL = NSURL(string: "http://leonbaird.co.uk/iphone/input.php")!
            let request = NSMutableURLRequest(URL: serviceURL)
            request.HTTPMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            resultLog.text! += "\nSending request...\n"
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: nil)
            let task = session.uploadTaskWithRequest(request, fromData: formData, completionHandler: { (result, response, error) -> Void in
                
                // run back on main thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let data = result, responseText = String(data: data, encoding: NSUTF8StringEncoding) {
                        self.resultLog.text! += "Response Text: \(responseText)\n"
                    } else if response != nil {
                        self.resultLog.text! += "Unable to parse response as string: \(response!.description)"
                    } else if error != nil {
                        self.resultLog.text! += "Network error: \(error!.localizedDescription)\n"
                    } else {
                        self.resultLog.text! += "Unknown error and no data received!\n"
                    }
                })
                
            })
            task.resume()
            
            // uploading image methods at bottom of class file
            uploadImageData(session)
        
        } catch let error as NSError {
            resultLog.text! += "Error parsing data: \(error.localizedDescription)\n"
        }
    }
    
    @IBAction func pickImage(sender: AnyObject) {
        let choice = UIAlertController(title: "Pick Image", message: "Choose source:", preferredStyle: .ActionSheet)
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            choice.addAction(UIAlertAction(title: "Camera", style: .Default, handler: openImagePicker))
        }
        choice.addAction(UIAlertAction(title: "Photo Library", style: .Default, handler: openImagePicker))
        choice.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(choice, animated: true, completion: nil)
    }
    
    func openImagePicker(action:UIAlertAction) {
        let picker = UIImagePickerController()
        picker.sourceType = action.title == "Camera" ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func clearForm(sender:UIButton) {
        for tf in textFields { tf.text = nil; tf.resignFirstResponder() }
        contactSwitch.selected = true
        serviceType.selectedSegmentIndex = 0
        imagePreview.image = UIImage(named: "Camera")
        imagePreview.contentMode = .Center
    }
    
    // MARK: - Validation methods
    
    func validateForm() -> Bool {
        var error = false
        if let surname = surnameTF.text, forname = forenameTF.text, email = emailTF.text {
            // check not empty and there is an image
            error = surname.isEmpty || forname.isEmpty || email.isEmpty || imagePreview.image == nil
            
            // validate email pattern
            do {
                let emailRegex = try NSRegularExpression(pattern: "[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}", options: .CaseInsensitive)
                let match = emailRegex.firstMatchInString(email, options: .Anchored, range: NSRange(location: 0, length: email.characters.count))
                error = error || match == nil
            } catch {}

        } else { return false }
        
        return !error
    }
    
    // MARK: - UITextfieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - UIImagePickerController Delegate Methods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePreview.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imagePreview.contentMode = UIViewContentMode.ScaleAspectFill
        imagePreview.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Image Uploading Methods:
    
    func uploadImageData(session:NSURLSession) {
        // upload image file only
        let serviceURL = NSURL(string: "http://leonbaird.co.uk/iphone/process-image-binary.php")!
        let request = NSMutableURLRequest(URL: serviceURL)
        request.HTTPMethod = "PUT"
        request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
        request.setValue("attachment; filename=\"\(surnameTF.text!)-image.jpg\"", forHTTPHeaderField: "Content-Disposition")
        
        // prepare the image data
        let imageData = UIImageJPEGRepresentation(imagePreview.image!, 1)!
        
        // add progress bar UI
        makeUploadView()
        
        imageUploadTask = session.uploadTaskWithRequest(request, fromData: imageData, completionHandler: { (data, response, error) -> Void in
            print("Image upload complete")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.removeUploadView()
                if data != nil && error == nil {
                    let responseText = String(data: data!, encoding: NSUTF8StringEncoding)!
                    self.resultLog.text! += "Image Upload Complete. Response from server:\n\(responseText)\n\n"
                } else if let e = error {
                    self.resultLog.text! += "Error from uploading image: \(e.localizedDescription)\n"
                    if let d = data, responseText = String(data: d, encoding: NSUTF8StringEncoding) {
                        self.resultLog.text! += "Response text received: \(responseText)\n"
                    }
                }
                self.resultLog.text! += "End of session.\n\n"
            })
            
        })
        imageUploadTask!.resume()
        
    }
    
    // MARK: - User Interface for Uploading Image
    
    weak var uploadView:UIView?
    weak var progressBar:UIProgressView?
    
    func makeUploadView() {
        let uploadView = ShadowView()
        uploadView.translatesAutoresizingMaskIntoConstraints = false
        uploadView.backgroundColor = UIColor.clearColor()
        view.addSubview(uploadView)
        view.addConstraints([
            NSLayoutConstraint(item: uploadView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: uploadView, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: uploadView, attribute: .Width,   relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 300),
            NSLayoutConstraint(item: uploadView, attribute: .Height,  relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 100),
        ])
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Uploading Progress:"
        title.font = UIFont.systemFontOfSize(21)
        uploadView.addSubview(title)
        uploadView.addConstraints([
                NSLayoutConstraint(item: title, attribute: .Top, relatedBy: .Equal, toItem: uploadView, attribute: .TopMargin, multiplier: 1, constant: 10),
                NSLayoutConstraint(item: title, attribute: .Left, relatedBy: .Equal, toItem: uploadView, attribute: .LeftMargin, multiplier: 1, constant: 20)
        ])
        
        let progressBar = UIProgressView()
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        uploadView.addSubview(progressBar)
        uploadView.addConstraints([
            NSLayoutConstraint(item: progressBar, attribute: .Left,  relatedBy: .Equal, toItem: uploadView, attribute: .LeftMargin,  multiplier: 1, constant: 20),
            NSLayoutConstraint(item: progressBar, attribute: .Right, relatedBy: .Equal, toItem: uploadView, attribute: .RightMargin, multiplier: 1, constant: -20),
            NSLayoutConstraint(item: progressBar, attribute: .Top,   relatedBy: .Equal, toItem: title,      attribute: .Bottom,      multiplier: 1, constant: 20)
        ])
        
        // setup appearance animation
        uploadView.alpha = 0
        uploadView.transform = CGAffineTransformMakeScale(1.5, 1.5)
        
        // animate
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
            uploadView.alpha = 1;
            uploadView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        self.uploadView = uploadView
        self.progressBar = progressBar
    }
    
    func removeUploadView() {
        UIView.animateKeyframesWithDuration(1, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModePaced, animations: {
            self.uploadView!.alpha = 0
            self.uploadView!.transform = CGAffineTransformMakeScale(1.5, 1.5)
        }) { (complete) -> Void in
            self.uploadView!.removeFromSuperview()
            self.uploadView = nil
            self.progressBar = nil
        }
    }
    
    // MARK: - sessionDelegateMethods
    var imageUploadTask:NSURLSessionUploadTask?
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        if task == imageUploadTask {
            let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
            dispatch_async(dispatch_get_main_queue(), {
                self.progressBar!.setProgress(progress, animated: true)
            })
        }
    }
    
    
    
}

