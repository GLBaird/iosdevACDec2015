//
//  WebkitViewController.swift
//  WebViews
//
//  Created by Leon Baird on 17/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit
import WebKit


class WebkitViewController: UIViewController, WKScriptMessageHandler {

    weak var webView:WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // configure view
        let config = WKWebViewConfiguration()
        config.userContentController.addScriptMessageHandler(self, name: "sendMessage")
        
        // create view interface
        let wv = WKWebView(frame: view.bounds, configuration: config)
        wv.autoresizingMask = [.FlexibleBottomMargin,.FlexibleTopMargin,
            .FlexibleLeftMargin,.FlexibleRightMargin,.FlexibleWidth,.FlexibleHeight]
        wv.frame.origin.y += 74
        wv.frame.size.height -= 128
        wv.frame.origin.x += 10
        wv.frame.size.width -= 20
        view.addSubview(wv)
        
        webView = wv
        
        // load content
        do {
            let indexPath = NSBundle.mainBundle().pathForResource("index", ofType: "html", inDirectory: "web-content")!
            let basePath  = NSBundle.mainBundle().pathForResource("web-content", ofType: nil)!
            let html      = try String(contentsOfFile: indexPath, encoding: NSUTF8StringEncoding)
            let baseURL   = NSURL(fileURLWithPath: basePath, isDirectory: true)
            webView.loadHTMLString(html, baseURL: baseURL)
        } catch let error as NSError {
            print("Error loading web- \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // actions
    
    @IBAction func sendMessage(sender: AnyObject) {
        webView.evaluateJavaScript("addLog('HI from swift')", completionHandler: nil)
    }
    
    @IBAction func getLog(sender: AnyObject) {
        webView.evaluateJavaScript("getLogText()") { (data, error) -> Void in
            if let responseText = data as? String {
                print("Data Received: \(responseText)")
            } else if error != nil {
                print("Error from JS \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func closeModalView(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: WKScriptHanlder protocol
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        print("Did receive message from javascript: \(message.body)")
    }

}
