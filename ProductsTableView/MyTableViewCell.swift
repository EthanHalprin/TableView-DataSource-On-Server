//
//  MyTableViewCell.swift
//  ProductsTableView
//
//  Created by Ethan Halprin on 17/05/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//

import Foundation
import UIKit


/// Class to hold the custom cell in TableView
class MyTableViewCell: UITableViewCell
{
    @IBOutlet var picture : UIImageView!
    @IBOutlet var title   : UILabel!
    @IBOutlet var body    : UILabel!
    
    internal var pictureURL : String!
    
    //
    // MARK: ------------ Overriders ------------
    //
    override func awakeFromNib()
    {
        super.awakeFromNib()
     
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //
    // MARK: ------------ Custom methods ------------
    //
    func setThumbnail(image : UIImage)
    {
        // self.imageView?.image = image
        // self.imageView?.contentMode = .scaleAspectFit
        // self.imageView?.clipsToBounds = true
        // self.imageView?.layer.masksToBounds = true
        
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.clipsToBounds = true
        self.imageView?.image = image

        self.imageView?.setNeedsDisplay()
    }
    func fill(pictureLink      : String,
              title            : String,
              body             : String)
    {
        self.pictureURL  = pictureLink
        self.title?.text = title
        self.body?.text  = body
    }
}
