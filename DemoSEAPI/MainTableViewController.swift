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

class MainTableViewController: UITableViewController,UISearchResultsUpdating{

    
    var searchController:UISearchController!

    var searchKeyword: String? // = "questions"
    
    // empty array to store the search results
    var jsonResponse: [Response] = []
    
    //empty array to store the filtered results
    var searchResults:[Response] = []
    
  
    
func alamofireFunction() {
    
    
        
        Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?=%20\(searchKeyword)%20viewpage=1&fromdate=1183075200&todate=2554416000&order=asc&sort=activity&tagged=ios&site=stackoverflow").responseJSON { (response) -> Void in
            
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
                        self.jsonResponse.append(result)
                        
                        }
                    
                    self.tableView.reloadData()
                    print(self.jsonResponse.count)
                }
                
            case .Failure:
                print("error")
                }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    searchController = UISearchController(searchResultsController: nil)
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    tableView.tableHeaderView = searchController.searchBar
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false

         //Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
     
        
        
        
        
        
        //Enabling self sizing cells
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        

        
        
        alamofireFunction()
        
        
        
        
        }
    

    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
//        if let searchText = searchController.searchBar.text {
//            filterContentForSearchText(searchText)
//            tableView.reloadData()
//        }
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let searchText = searchController.searchBar.text {
            searchKeyword = searchText
        
        
        } else {
            searchKeyword = "questions"
        
        }
        alamofireFunction()
        tableView.reloadData()
        

    }
    
    

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    // MARK: - Table view data source


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell

      //  let response = (searchController.) ? searchResults[indexPath.row] : jsonResponse[indexPath.row]
        
        if searchResults.isEmpty {
        
        // Configure the cell...
        cell.questionLabel.text = jsonResponse[indexPath.row].question
        cell.nameLabel.text = jsonResponse[indexPath.row].name
            cell.avatarLabel.load(jsonResponse[indexPath.row].image) }
            else {
        cell.questionLabel.text = searchResults[indexPath.row].question
        cell.nameLabel.text = searchResults[indexPath.row].name
            cell.avatarLabel.load(searchResults[indexPath.row].image)
        
        }
        
            //        cell.nameLabel.text = response.name
//            cell.avatarLabel.load(response.image) }
        
        
        return cell
    }

    
    
    

    
    
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            
            if searchController.active {
                return searchResults.count
            } else {
            return jsonResponse.count
            }
            
    }

    
    
    

}
