//
//  ViewController.swift
//  ProductsTableView
//
//  Created by Ethan Halprin on 17/05/2017.
//  Copyright © 2017 Ethan Halprin. All rights reserved.
//

import UIKit


/// Main View Controller - will accomodate our main TableView
/// and its datasource (seperate class for a better modularity).
/// This VC is also resonsible for issuing network calls
/// on Model to fetch the data source for the table and its
/// thumbnails pictures.
/// These calls shall be executed in the background (global Q async)
/// to support responsiveness
class ViewController: UIViewController,
                      UITableViewDataSource,
                      UITableViewDelegate
{
    @IBOutlet var tableView: UITableView!
    
    let cellReuseIdentifier = "CellReuseID123456"
    let remoteJsonUrl       = "https://api.myjson.com/bins/1g83ip"
    let network             = NetworkSession()

    var productsDataSource : [Product]! = [Product]()

    //
    // MARK: ------------ viewDidLoad ------------
    //
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //
        // Already on Storyboard:
        //
        //  tableView.delegate   = self
        //  tableView.dataSource = self
        //  tableView.register(MyTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        //
        
        //
        // Go fetch data from server on background (URLSession is asynced)
        //
        DispatchQueue.global().async
        {
            self.network.fetchProducts(productsURL: self.remoteJsonUrl,
                                       success: self.successProductsFetch,
                                       failure: self.failProductsFetch)
        }
    }
    //
    // MARK: ------------ Fetch Async CallBacks ------------
    //
    func successProductsFetch(dict : [Product])
    {
        DispatchQueue.main.async
        {
            self.productsDataSource = dict
            self.tableView.reloadData()
        }
    }
    func failProductsFetch(err : Error?)
    {
        if let err = err
        {
            print("\(err.localizedDescription)")
        }
    }
    func failImageFetch(err : Error?)
    {
        if let err = err
        {
            print("\(err.localizedDescription)")
        }
    }
    func successImageFetch(fetchedImage: UIImage?, cacheKey: Int32)
    {
    }
    //
    // MARK: ------------ UITableViewDataSource ------------
    //
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        guard self.productsDataSource != nil else { return 0 }
        
        return self.productsDataSource.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("-------cellForRowAt IndexPath = row:\(indexPath.row) section:\(indexPath.section)--------------")

        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MyTableViewCell
        
        guard self.productsDataSource != nil else { return cell }
    
        /// Load cell content
        cell.title.text = productsDataSource[indexPath.row].title
        cell.body.text  = productsDataSource[indexPath.row].body
        cell.pictureURL = productsDataSource[indexPath.row].imageURL
        cell.imageView?.image = nil
        
        /// Attain thumbnail asynchronously
        if let thumbnailURL = cell.pictureURL
        {
            DispatchQueue.global().async
            {
                /// Mind we send the indexPath, so when resultClosure
                /// returns, we will know which cell to fetch...
                self.network.fetchThumbnail(thumbnailURL : thumbnailURL,
                                            indexPath    : indexPath,
                                            resultClosure: self.fetchThumbnailClosure)
            }
        }
        
        return cell
    }
    func fetchThumbnailClosure(image: UIImage, indexPath: IndexPath)
    {
        DispatchQueue.main.async
        {
            let cell = self.tableView.cellForRow(at: indexPath) as! MyTableViewCell?
            
            if let cell = cell
            {
                cell.picture?.image = image
                cell.setNeedsLayout()
            }
        }
    }
}

