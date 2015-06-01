//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Mads Bielefeldt on 31/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController
{
    // MARK: - Definitions
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    
    // MARK: - Model
    
    var tweets = [[Tweet]]()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let request = TwitterRequest(search: "#stanford", count: 100)
        
        request.fetchTweets { (newTweets) -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if newTweets.count > 0 {
                    self.tweets.insert(newTweets, atIndex: 0)
                    self.tableView.reloadData()
                }
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return tweets.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tweets[section].count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier(Storyboard.CellReuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        let tweet = tweets[indexPath.section][indexPath.row]
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user.name

        return cell
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
}
