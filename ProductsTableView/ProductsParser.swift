//
//  ProductsParser.swift
//  ProductsTableView
//
//  Created by Ethan Halprin on 17/05/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//

import UIKit


/// Parses a stream of Data object to a Products vector
/// using `JSONSerialization`
class ProductsParser : NSObject
{
    var parsedObjects : [Product]? = nil
    
    func parse(jsonData: Data?) -> [Product]?
    {
        do
        {
            /// Observe json structure to determine downcast type
            guard let products = try? JSONSerialization.jsonObject(with: jsonData!, options: []) as? [[String:AnyObject]] else
            {
                print("error trying to convert data to JSON")
                return nil
            }
            
            print(products as Any)
            
            parsedObjects = [Product]()
            
            /// Mind what type `p` is according to json single cell
            for p in products!
            {
                let newProductObj = Product()
               
                newProductObj.imageURL = p["thumbnail"]  as! String!
                newProductObj.title    = p["name"] as! String!
                newProductObj.body     = p["role"] as! String!
                
                parsedObjects!.append(newProductObj)
            }
            
            return parsedObjects
        }
    }
}
