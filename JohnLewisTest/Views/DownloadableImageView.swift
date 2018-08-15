//
//  DownloadableImageView.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//
// Download and cache our images as the user scrolls, cancel if required.

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

class DownloadableImageView: UIImageView {
    var downloadURL: URL?
    
    func loadImage(with url: URL) {
        self.downloadURL = url
        
        let urlString: NSString = url.absoluteString as NSString
        
        // Lets see if the image exists already
        if let cachedImage = imageCache.object(forKey: urlString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // If we dont have an image in our cache, download one
        URLSession.shared.dataTask(with: url, completionHandler: {data, response, error -> Void in
            
            // Maybe do something if it fails, for now failing silently as this is a test
            if error != nil {
                return
            }
            
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    imageCache.setObject(image, forKey: urlString)
                    self.image = image
                }
            }
            
        }).resume()
    }
    
    func cancelExistingDownload() {
        if self.image == nil {
            URLSession.shared.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
                for task in dataTasks {
                    if let originalURL = task.originalRequest?.url, originalURL == self.downloadURL {
                        task.cancel()
                        break
                    }
                }
            })
        }
    }
}
