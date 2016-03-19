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

class MainTableViewController: UITableViewController,UISearchResultsUpdating{

    
  let searchController = UISearchController(searchResultsController: nil)

    var searchKeyword: String = "questions"
    
    // empty array to store the search results
    var searchResults: [SearchResult] = []
   
    
  
    
func alamofireFunction() {
        
        
        Alamofire.request(.GET, "https://api.stackexchange.com/2.2/questions?=%20\(searchKeyword)%20viewpage=1&fromdate=1183075200&todate=2554416000&order=asc&sort=activity&tagged=ios&site=stackoverflow").responseJSON { (response) -> Void in
            
            switch response.result {
                
            case .Success:
                if let value = response.result.value {
                    
                    
                    let json = JSON(value)
                    
                    
                    for (var idx=0; idx<=json["items"].count; idx++) {
                        let result = SearchResult()
                        //print(json["items"][idx]["title"].stringValue)
                        result.name = json["items"][idx]["owner"]["display_name"].stringValue
                        result.question = json["items"][idx]["title"].stringValue
                        result.image = json["items"][idx]["owner"]["profile_image"].stringValue
                        self.searchResults.append(result)
                        
                        
                        
                        
                    }
                    
                    self.tableView.reloadData()
                    print(self.searchResults.count)
                    


                    
                }
                
            case .Failure:
                print("error")
                
                
                
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
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
        
    }
    
    
    
    
    
    

    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    // MARK: - Table view data source


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MainTableViewCell

        // Configure the cell...
        
     
        cell.questionLabel.text = searchResults[indexPath.row].question
        cell.nameLabel.text = searchResults[indexPath.row].name
        
     //cell.avatarLabel.image = UIImage(
        
        
        //cell.avatarLabel.image = searchResults[indexPath.row].image
       
        
        return cell
    }

    
    
    

    
    
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return searchResults.count
            
    }

    
    
    

}
