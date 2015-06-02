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
                if let imageData = NSData(contentsOfURL: profileImageURL) {
                    tweetProfileImageView?.image = UIImage(data: imageData)
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
