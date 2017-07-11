//
//  Product.swift
//  ProductsTableView
//
//  Created by Ethan Halprin on 17/05/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//

import UIKit

/// class to hold a single product item (Usually has
/// picture + title + body. Add properties if needed)
class Product: NSObject
{
    var imageURL : String!
    var title    : String!
    var body     : String!
    
    override init()
    {
        super.init()
    }
    convenience init(image: String?, title: String, body: String)
    {
        self.init()
        
        self.imageURL = image
        self.title    = title
        self.body     = body
    }
}
