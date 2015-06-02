//
//  TweetTableViewController.swift
//  Smashtag
//
//  Created by Mads Bielefeldt on 31/05/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class TweetTableViewController: UITableViewController, UITextFieldDelegate
{
    // MARK: - Definitions
    
    private struct Storyboard {
        static let CellReuseIdentifier = "Tweet"
    }
    
    // MARK: - Model
    
    var tweets = [[Tweet]]()
    
    var searchText: String? = "#stanford" {
        didSet {
            searchTextField?.text = searchText
            tweets.removeAll()
            tableView.reloadData()
            refresh()
        }
    }
    
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        refresh()
    }
    
    private func refresh()
    {
        if searchText != nil {
            let request = TwitterRequest(search: searchText!, count: 100)
            
            request.fetchTweets { (newTweets) -> Void in
                dispatch_async(dispatch_get_main_queue()) { () -> Void in
                    if newTweets.count > 0 {
                        self.tweets.insert(newTweets, atIndex: 0)
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - UITextFieldDelegate
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.delegate = self
            searchTextField.text = searchText
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        if textField == searchTextField {
            textField.resignFirstResponder()
            searchText = textField.text
        }
        
        return true
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
