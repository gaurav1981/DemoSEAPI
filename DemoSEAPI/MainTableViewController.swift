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

class MainTableViewController: UITableViewController,UISearchResultsUpdating {

    
    var searchController = UISearchController(searchResultsController: nil)

    var searchKeyword: String! // = ""
    
    // empty array to store the search results
    var jsonResponse: [Response] = []
    
    //empty array to store the filtered results
    var searchResults:[Response] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    definesPresentationContext = true
    
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
         //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //Enabling self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension

       // alamofireFunction()
        }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
//        if searchController.active && searchController != ""{
//            return searchResults.count
//        }
//        
//        else {
//            return jsonResponse.count
//        }
//        
return searchResults.count
    
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell
        
        
        
        if searchController.active {
            print("no of elements in searchResults is \(searchResults.count)")
            cell.questionLabel.text = searchResults[indexPath.row].question
            cell.nameLabel.text = searchResults[indexPath.row].name
            cell.avatarLabel.load(searchResults[indexPath.row].image)
       }
            //else {
//            print(jsonResponse.count)
//            cell.questionLabel.text = jsonResponse[indexPath.row].question
//            cell.nameLabel.text = jsonResponse[indexPath.row].name
//            cell.avatarLabel.load(jsonResponse[indexPath.row].image)
//        }
    
        
//        if searchResults.isEmpty {
//            
//            // Configure the cell...
//            cell.questionLabel.text = jsonResponse[indexPath.row].question
//            cell.nameLabel.text = jsonResponse[indexPath.row].name
//            cell.avatarLabel.load(jsonResponse[indexPath.row].image) }
//        else {
//            cell.questionLabel.text = searchResults[indexPath.row].question
//            cell.nameLabel.text = searchResults[indexPath.row].name
//            cell.avatarLabel.load(searchResults[indexPath.row].image)
//            
//        }
        
        //        cell.nameLabel.text = response.name
        //            cell.avatarLabel.load(response.image) }
        
        
        return cell
    }
    
    func alamofireFunction(query: String) {
        //query = searchKeyword
        
        Alamofire.request(.GET, "https://api.stackexchange.com/2.2/search?order=asc&sort=activity&tagged=ios&intitle=\(query)%20controller&site=stackoverflow").responseJSON { (response) -> Void in
            
            switch response.result {
                
            case .Success:
                
                
                
                if let value = response.result.value {
                    
                    
                    let json = JSON(value)
                    
                    
                    for (var idx=0; idx<=json["items"].count; idx++) {
                        let result = Response()
                        //print(json["items"][idx]["title"].stringValue)
                        result.name = json["items"][idx]["owner"]["display_name"].stringValue
                        result.question = json["items"][idx]["title"].stringValue
                        result.image = json["items"][idx]["owner"]["profile_image"].stringValue
                        //if self.searchController.active && self.searchController != ""{
                        
                        print(json["items"][idx]["title"].stringValue)
                        
                        if self.searchResults.isEmpty {
                            self.searchResults.append(result)
                            self.tableView.reloadData()
                            
                        } else {
                            self.searchResults.removeAll()
                            self.searchResults.append(result)
                            self.tableView.reloadData()
                            
                        }
                      
                        
                    }
                    
    
                }
                
            case .Failure:
                print("error")
            }
        }
        
        
    }
    
    
    
    
    
    

    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        
        if let searchText = searchController.searchBar.text {
          
            searchKeyword = searchText
            
            
            alamofireFunction(searchKeyword)
            

            
        }
        //tableView.reloadData()
    }
  
    
    
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source



    
  

}
