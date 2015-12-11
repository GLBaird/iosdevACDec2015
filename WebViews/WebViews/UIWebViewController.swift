//
//  ViewController.swift
//  WebViews
//
//  Created by Leon Baird on 17/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class UIWebViewController: UIViewController, UIWebViewDelegate {
    
    // outlets
    @IBOutlet weak var webview: UIWebView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get URL to resources
        let indexPath  = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "web-content")
        let baseFolder = NSBundle.mainBundle().pathForResource("web-content", ofType: nil)
        let baseURL  = NSURL(fileURLWithPath: baseFolder!, isDirectory: true)
        let indexData = NSData(contentsOfFile: indexPath!)!
        
        
        webview.loadData(indexData, MIMEType: "text/html", textEncodingName: "utf-8", baseURL: baseURL)
        webview.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action methods
    
    @IBAction func buttonClicked(sender: AnyObject) {
        webview.stringByEvaluatingJavaScriptFromString("addLog('HI from Swift')")
        let response = webview.stringByEvaluatingJavaScriptFromString("getLogText()")
        print("Returned from JS Log: \(response)")
    }

    // MARK: - UIWebview Delegate methods
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        // to collect data from webview, analyse URL Request to get information from webview - return false to prevent request from loading.
        // BUT the first load will be the initial page content, so allow that!
        print("Load Received!")
        return true
    }

}

