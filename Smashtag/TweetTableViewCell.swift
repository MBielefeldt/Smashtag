//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by Mads Bielefeldt on 02/06/15.
//  Copyright (c) 2015 GN ReSound. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{
    var tweet: Tweet? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetScreenNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    private func updateUI()
    {
        tweetProfileImageView?.image = nil
        tweetScreenNameLabel?.text = nil
        tweetTextLabel?.text = nil
        
        if let tweet = self.tweet {
            if let profileImageURL = tweet.user.profileImageURL {
                let qos = Int(QOS_CLASS_USER_INTERACTIVE.value)
                dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
                    if let imageData = NSData(contentsOfURL: profileImageURL) {
                        dispatch_async(dispatch_get_main_queue()) { () -> Void in
                            if profileImageURL == self.tweet?.user.profileImageURL {
                                self.tweetProfileImageView?.image = UIImage(data: imageData)
                            }
                        }
                    }
                }
            }
            
            tweetScreenNameLabel?.text = "\(tweet.user)"
            
            tweetTextLabel?.text = tweet.text
            if tweetTextLabel?.text != nil {
                for _ in tweet.media {
                    tweetTextLabel.text! += " 📷"
                }
            }
        }
    }
}
