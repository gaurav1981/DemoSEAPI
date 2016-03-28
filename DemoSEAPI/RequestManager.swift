//
//  RequestManager.swift
//  DemoSEAPI
//
//  Created by ashiq on 28/03/16.
//  Copyright © 2016 ashiq. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestManager {
var searchResults = [JSON]()
    
    //for pagination condition check
    var pageNumber = 1
    var pageString: String {
        if pageNumber == 1 {
            return ""
        } else {
           return "page=\(pageNumber)&"
        }
    }
    
    var hasMore = false
    
    func alamofireFunction(query: String) {
        
//        let url = "https://api.stackexchange.com/2.2/search?\(pageString)order=asc&sort=activity&tagged=ios&intitle=\(query)&%20controller&site=stackoverflow"
        
        let url = "https://api.stackexchange.com/2.2/search?\(pageString)order=desc&sort=activity&intitle=\(query)&site=stackoverflow"
        Alamofire.request(.GET, url).responseJSON { (response) -> Void in
            
                            if let value = response.result.value  as? [String: AnyObject] {
                    //print("value is \(value)")
                                let items = JSON(value["items"]!).arrayValue
                                self.hasMore = JSON(value["has_more"]!).boolValue
                                self.searchResults += items
                                NSNotificationCenter.defaultCenter().postNotificationName("searchResultsUpdated", object: nil  )
                                

                                
                    //let json = JSON(value)
//                    for (var idx=0; idx<=json["items"].count; idx++) {
//                    
//                        let result = Response()
//                        result.name = json["items"]["owner"]["display_name"].stringValue
//                        result.question = json["items"]["title"].stringValue
//                        result.image = json["items"]["owner"]["profile_image"].stringValue
//                        self.searchResults.append(result)
//                        
//                        print("number of items in the array is \(self.searchResults.count)")
//                        
//                        
//                    }
                    
                    
                }
                
            }
        
        
    }
    
    //to load the next page
    func getNextPage(query: String) {
        pageNumber += 1
        alamofireFunction(query)
    }
    
    // to reset the search 
    func resetSearch() {
        searchResults.removeAll()
    }
    
    
    
}
