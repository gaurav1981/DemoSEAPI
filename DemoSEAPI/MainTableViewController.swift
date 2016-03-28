//
//  MainTableViewController.swift
//  DemoSEAPI
//
//  Created by ashiq on 15/03/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImageLoader

class MainTableViewController: UITableViewController, UISearchBarDelegate{

    
    var searchController = UISearchController(searchResultsController: nil)
    let requestManager = RequestManager()
    
    
    var validatedText: String{
        return searchController.searchBar.text!.stringByReplacingOccurrencesOfString(" ", withString: "").lowercaseString
    }
    
    //empty array to store the filtered results
    var searchResults:[JSON] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    searchController.searchBar.delegate = self
    tableView.tableHeaderView = searchController.searchBar
    searchController.dimsBackgroundDuringPresentation = false
    searchController.hidesNavigationBarDuringPresentation = false
    definesPresentationContext = true
        
        
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateSearchResults", name: "searchResultsUpdated", object: nil)
        
        //Enabling self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension

    
        }
    
    func updateSearchResults() {
        
        //print(requestManager.searchResults)
        searchResults = requestManager.searchResults
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return searchResults.count
    
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell
        
        cell.nameLabel?.text = searchResults[indexPath.row]["owner"]["display_name"].stringValue
        cell.questionLabel?.text = searchResults[indexPath.row]["title"].stringValue
        cell.avatarLabel.load(searchResults[indexPath.row]["owner"]["profile_image"].stringValue)

      
        
       
        if indexPath.row == searchResults.count - 10 {
            if requestManager.hasMore {
                requestManager.getNextPage(validatedText)
            }
        }
        
        return cell
    }
    
  

    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        requestManager.resetSearch()
        updateSearchResults()
        requestManager.alamofireFunction(validatedText)
       
        
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

}
