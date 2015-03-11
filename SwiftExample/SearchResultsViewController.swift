//
//  SearchResultsViewController.swift
//  SwiftExample
//
//  Created by Macpro033 on 20/01/15.
//  Copyright (c) 2015 Macpro033. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, APIControllerProtocol{
    var api = APIController()
    var myString="My Sample."
    let myCons="Constant"
    let kSomeConstant: Int = 40
  let kSomeCons2=60
    var tableData = []
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    
    
    var colorsArray=["Blue","Red","Green","Yellow"]
//    var colorDictionary=["PrimaryColor":"Green","Secondary":"Blue","Third":"Red
    override func viewDidLoad() {
        super.viewDidLoad()
        api.searchItunesFor("Bit Cage")
        self.api.delegate=self;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        
        let rowData: NSDictionary = self.tableData[indexPath.row] as NSDictionary
        
        cell.textLabel?.text = rowData["trackName"] as? String
        
        // Grab the artworkUrl60 key to get an image URL for the app's thumbnail
        let urlString: NSString = rowData["artworkUrl60"] as NSString
        let imgURL: NSURL? = NSURL(string: urlString)
        
        // Download an NSData representation of the image at the URL
        let imgData = NSData(contentsOfURL: imgURL!)
        if((imgData) != nil){
        cell.imageView?.image = UIImage(data: imgData!);
        }
        // Get the formatted price string for display in the subtitle
        let formattedPrice: NSString = rowData["formattedPrice"] as NSString
        
        cell.detailTextLabel?.text = formattedPrice
        
        return cell
    }
    
//    func searchItunesFor(searchTerm: String) {
//        
//        // The iTunes API wants multiple terms separated by + symbols, so replace spaces with + signs
//        let itunesSearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
//        
//        // Now escape anything else that isn't URL-friendly
//        if let escapedSearchTerm = itunesSearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding) {
//            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
//            let url = NSURL(string: urlPath)
//            let session = NSURLSession.sharedSession()
//            let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
//                println("Task completed")
//                if(error != nil) {
//                    // If there is an error in the web request, print it to the console
//                    println(error.localizedDescription)
//                }
//                var err: NSError?
//                
//                var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
//                if(err != nil) {
//                    // If there is an error parsing JSON, print it to the console
//                    println("JSON Error \(err!.localizedDescription)")
//                }
//                let results: NSArray = jsonResult["results"] as NSArray
//                dispatch_async(dispatch_get_main_queue(), {
//                    self.tableData = results
//                    self.myTableView!.reloadData()
//                })
//            })
//            
//            task.resume()
//        }
//    }
    
    func didReceiveAPIResults(results: NSDictionary) {
        var resultsArr: NSArray = results["results"] as NSArray
        dispatch_async(dispatch_get_main_queue(), {
            self.tableData = resultsArr
            self.myTableView!.reloadData()
        })
    }


}

