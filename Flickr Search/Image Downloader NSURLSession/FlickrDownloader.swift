//
//  FlickrDownloader.swift
//  Image Downloader NSURLSession
//
//  Created by Leon Baird on 12/09/2015.
//  Copyright © 2015 Leon Baird. All rights reserved.
//

import UIKit

class FlickrDownloader {

    private let baseURL = "https://api.flickr.com"
    private let api     = "services/rest"
    private let method  = "method=flickr.photos.search"
    private let apiKey  = "api_key=adc17bd58da2a6e42a724ba98ceb6c89"
    private let media   = "media=photos"
    private let format  = "format=json"
  
    private var requestURL:String {
        return "\(baseURL)/\(api)?\(method)&\(apiKey)&\(media)&\(format)&nojsoncallback=1"
    }
    
    private func getRequestURL(searchText:String) -> NSURL? {
        // URL Encoding now built into Swift String! use stringsByAddingPercetEncodingWithAllowedCharacters and choose NSCharacterSet
        if let searchTextEncoded = searchText.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet()) {
                    return NSURL(string: requestURL + "&text=" + searchTextEncoded)
        }
        return nil
    }
    
    // internal is public but only for this app package - public is for frameworks
    internal var delegate:FlickrDownloaderDelegate?
    
    // can initialise without delegate if using completion closures
    convenience init() { self.init(delegate: nil) }
    
    // if you prefer delegation (though I am not giving the delegate a break down of the download process)
    // If I wanted to do that, I would become the delegate of the session and pass the information along
    init(delegate:FlickrDownloaderDelegate?) {
        self.delegate = delegate
    }
    
    // Encode the search text and download response without completion closure
    func searchImages(searchText:String) {
        searchImages(searchText, completion: nil)
    }
    
    // encode the search text and download response with optional compeltion closure
    func searchImages(searchText:String, completion:((images:[FlickrImage]?, error:NSError?)->Void)?) {
        
        // configure session for default download and caching (others include no caching and downloading on background)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        // make our URL if possible from search query
        if let url = getRequestURL(searchText) {
            
            // make a task using completion closure (you could also become a delegate if you need a breakdown of the progress)
            let task = session.dataTaskWithURL(url, completionHandler: {
                jsonData, response, error in
            
                // in response closure with the above variables:
                //      jsonData:NSData, response:NSResponse, error:NSError (all of which are optional)
                
                if error == nil && jsonData != nil {
                    
                    // print retrieved data as string
                    // print("results: \(String(data: jsonData!, encoding: NSUTF8StringEncoding)))")
                    
                    // do all throwable errors here
                    do {
                        let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .MutableContainers) as! Dictionary<String, AnyObject>

                        if let photos = json["photos"]?["photo"] as? [Dictionary<String, AnyObject>] {
                            
                            // create storage array and flick through building image URLS and name details
                            // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_{SIZE:b(large),n(small)}.jpg

                            var parsedPhotos:[FlickrImage] = []
                            
                            for details in photos {
                                // get details to build URLs
                                let farm    = details["farm"] as! Int
                                let server  = details["server"] as! String
                                let photoID = details["id"] as! String
                                let secret  = details["secret"] as! String
                                
                                // convert data to model
                                let pic = FlickrImage(
                                    name: details["title"] as! String,
                                    thumbURL: "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_n.jpg",
                                    fullURL:  "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_b.jpg"
                                )
                                
                                parsedPhotos.append(pic)
                            }
                                                        
                            dispatch_async(dispatch_get_main_queue(), {
                                completion?(images: parsedPhotos, error: nil)
                                self.delegate?.flickrDownloader(self, receivedData: parsedPhotos)
                            })
                            
                            return
                        }
                        
                    } catch let error as NSError {
                        dispatch_async(dispatch_get_main_queue(), {
                            completion?(images: nil, error: error)
                            self.delegate?.flickrDownloader(self, receivedError: error)
                        })
                    }
                    
                    
                    // Failed for unknown parsing reasons
                    self.passOnError(
                        "Failed to download and parse Flickr Files",
                        recovery: "Check Flickr API Documentation agains this class",
                        completionHanlder: completion
                    )
                    
                } else {
                    // download error, pass on to closure and delegate (if exists?)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.passOnError(
                            "Failed to parse JSON Data",
                            recovery: "Check Flickr APIs for advice",
                            completionHanlder: completion
                        )
                    })
                }
            })
            task.resume()
        }
        
    }
    
    func passOnError(description:String, recovery:String, completionHanlder: ((images:[FlickrImage]?, error:NSError?)->Void)?) {
        let error = NSError(domain: "FlickrDownloader", code: 400, userInfo: [
            NSLocalizedDescriptionKey: description,
            NSLocalizedRecoverySuggestionErrorKey: recovery
        ])
        delegate?.flickrDownloader(self, receivedError: error)
        completionHanlder?(images: nil, error: error)
    }
}

protocol FlickrDownloaderDelegate {
    
    func flickrDownloader(downloader:FlickrDownloader, receivedData:[FlickrImage])
    func flickrDownloader(downloader:FlickrDownloader, receivedError:NSError)
    
}


