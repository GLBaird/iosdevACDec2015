//
//  GetPostViewController.swift
//  Networking
//
//  Created by Leon Baird on 11/12/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class GetPostViewController: UIViewController, NSXMLParserDelegate {
    
    // outlets
    @IBOutlet weak var logText: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action methods
    
    @IBAction func get(sender: AnyObject) {
        let urlComponent = NSURLComponents(string: "http://leonbaird.co.uk/iphone/input.php")!
        urlComponent.queryItems = [
            NSURLQueryItem(name: "username", value: "Leon Baird"),
            NSURLQueryItem(name: "APIKey", value: "LB2038473826"),
            NSURLQueryItem(name: "info", value: "I like pies")
        ]
        
        let serviceURL = urlComponent.URL!
        do {
            let response = try String(contentsOfURL: serviceURL, encoding: NSUTF8StringEncoding)
            logText.text = response
        } catch {
            logText.text = "Error"
        }
    }
    @IBAction func post(sender: AnyObject) {
        let urlComponent = NSURLComponents(string: "http://leonbaird.co.uk/iphone/input.php")!
        urlComponent.queryItems = [
            NSURLQueryItem(name: "username", value: "Leon Baird"),
            NSURLQueryItem(name: "APIKey", value: "LB2038473826"),
            NSURLQueryItem(name: "info", value: "I like pies")
        ]
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://leonbaird.co.uk/iphone/input.php")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = urlComponent.query?.dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            // remember, code here is on background thread!!
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                // main thread again
                if error != nil {
                    
                    self.logText.text = "Error "+error!.localizedDescription
                    
                } else if let d = data, dataString = String(data: d, encoding: NSUTF8StringEncoding) {
                    
                    self.logText.text = "Response text: " + dataString
                    
                } else {
                    self.logText.text = "No Reponse"
                }
            })
        }
        
        task.resume()
        
    }
    @IBAction func json(sender: AnyObject) {
        
        let jsonURL = NSURL(string: "http://leonbaird.co.uk/iphone/userdata.json")!
        if let jsonData = NSData(contentsOfURL: jsonURL) {
            
            do {
                let parsedData = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! Dictionary<String, Array<Dictionary<String, AnyObject>>>
            
                logText.text = parsedData.description
                
                let person3Name = parsedData["users"]![2]["name"] as! String
                logText.text! += "\nName is \(person3Name)"
                
            } catch {
                logText.text = "Parse Error"
            }
            
        } else {
            logText.text = "Error"
        }
        
    }
    
    @IBAction func xml(sender: AnyObject) {
        
        let xmlURL = NSURL(string: "http://leonbaird.co.uk/iphone/userdata.xml")!
        if let parser = NSXMLParser(contentsOfURL: xmlURL) {
            
            parser.delegate = self
            parser.parse()
            
        } else {
            logText.text = "Failed to download and parse data in XML"
        }
        
    }
    
    
    // MARK: - NSXMLParser Delegate Methods
    
    var xmlParsed:[Dictionary<String, String>]?
    var currentRecord:Dictionary<String, String>?
    var currentValue:String?
    
    func parserDidStartDocument(parser: NSXMLParser) {
        xmlParsed = [Dictionary<String, String>]()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        switch elementName {
            
            case "user-data":
            print("Staring new Document")
            
            case "user":
            currentRecord = Dictionary<String, String>()
            currentRecord!["id"] = attributeDict["id"]
            
            case "name", "address":
            currentValue = ""
            
        default:
            break;
            
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentValue != nil {
            currentValue! += string
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
            
            case "user-data":
            print("End of Document")
            
            case "user":
            xmlParsed!.append(currentRecord!)
            currentRecord = nil
            
            case "name", "address":
            currentRecord![elementName] = currentValue!
            currentValue = nil
            
        default:
            break;
            
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        logText.text = "Finished parsing XML: " + xmlParsed!.description
    }

}
