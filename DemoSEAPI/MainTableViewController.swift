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

class MainTableViewController: UITableViewController,UISearchResultsUpdating {

//    let searchController = UISearchController(searchResultsController: nil)
//    var questionArray:[String] = []
//    var tagsArray:[String] = []
//    var nameArray:[String] = []
//    var avatarArray: [String] = []
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
                    print(self.searchResults.count)

                    
//                    for (var idx=0; idx<=json["items"].count; idx++) {
//                        
//                        //print(json["items"][idx]["title"].stringValue)
//                        
//                        self.questionArray.append(json["items"][idx]["title"].stringValue)
//                        
//                    
//                        
//                        
//                        //self.tagsArray(json["items"][idx]["tags"].stringValue)
//                        self.nameArray.append(json["items"][idx]["owner"]["display_name"].stringValue)
//                        self.avatarArray.append(json["items"][idx]["owner"]["profile_image"].stringValue)
//                        //print(json["items"][idx]["tags"].arrayValue)
//                        
//                        
//                    }
                    
                    
                }
                
            case .Failure:
                print("error")
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        searchController.searchResultsUpdater = self
//        searchController.dimsBackgroundDuringPresentation = false
//        definesPresentationContext = true
//        tableView.tableHeaderView = searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
     
        
        
        

        
        
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
        
        //cell.questionLabel.text =   questionArray[indexPath.row]
        
   
    
//        for questions in sample {
//            cell.questionLabel.text = sample.description
//            
//            
//        }
     
        //cell.questionLabel.text = searchResults[indexPath.row].question
        
        
        return cell
    }

    
    
        override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }
    
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return 20
    }

    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
