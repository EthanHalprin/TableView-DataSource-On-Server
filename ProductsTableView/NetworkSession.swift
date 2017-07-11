//
//  NetworkSession.swift
//  ProductsTableView
//
//  Created by Ethan Halprin on 17/05/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//

import UIKit


/// Simple enum to hold JSON error string values
///
/// - NoData: Noting fetched
/// - ConversionFailed: Rendring from JSON structure failed
enum JSONError: String, Error
{
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


/// Your outlet to the internet! Also posseses:
///
/// - An inner parser: enabling result handlers to
/// return already parsed dictionary
/// - Discretionary ability: allowing tranferring 
/// at times that are more optimal for the device
class NetworkSession : NSObject
{
    var parser : ProductsParser? = nil

    
    func fetchProducts(productsURL : String?,
                       success: @escaping ([Product])->(),
                       failure: @escaping (Error)->())
    {
        guard let u = productsURL else { return }
        
        let url : URL = URL(string: u)!
        let request: URLRequest = URLRequest(url:url)
        let config = URLSessionConfiguration.default
        
        config.isDiscretionary = true
        
        let session = URLSession(configuration: config)
        
        self.parser = ProductsParser()
        
        let task = session.dataTask(with: request)
        {
            (responseData, response, error) in
            
            if(error != nil)
            {
                print(error?.localizedDescription ?? "")
                failure(error!)
            }
            else
            {
                let items = self.parser?.parse(jsonData: responseData)
                
                if let items = items
                {
                    success(items)
                }
            }
        };
        task.resume()
    }
    
    func fetchThumbnail(thumbnailURL: String, indexPath: IndexPath, resultClosure: @escaping (UIImage, IndexPath)->())
    {
        let url : URL = URL(string: thumbnailURL)!
        let request: URLRequest = URLRequest(url:url)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request)
        {
            (responseData, response, error) in
            
            if let e = error
            {
                print("Error downloading thumbnail picture: \(e)")
            }
            else
            {
                if let res = response as? HTTPURLResponse
                {
                    print("Downloaded thumbnail picture with response code \(res.statusCode)")
                    
                    if let imageData = responseData
                    {
                        let image = UIImage(data: imageData)
                        
                        if let image = image
                        {
                            resultClosure(image, indexPath)
                        }
                    }
                }
            }
            
        } // of `let task`
        
        task.resume()
    }
}
