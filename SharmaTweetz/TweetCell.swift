//
//  TweetCell.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            let user = tweet.user as User!
            userImageView.setImageWithURL(user.profileImageUrl)
            nameLabel.text = user.name
            usernameLabel.text = "@" + user.screenname!
            tweetLabel.text = tweet.text
            
            let retweeted = tweet.isRetweeted! as Bool!
            if (retweeted ?? false) {
                self.retweetImageView.image = UIImage(named: "retweet_on")
            } else {
                self.retweetImageView.image = UIImage(named: "retweet_default")
            }
            
            let favourited = tweet.isFavourited! as Bool!
            if (favourited ?? false) {
                self.favouriteImageView.image = UIImage(named: "favorite_on")
            } else {
                self.favouriteImageView.image = UIImage(named: "favorite_default")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
        
        replyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "replyClicked"))
        retweetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "retweetClicked"))
        favouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "favouriteClicked"))

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tweetLabel.preferredMaxLayoutWidth = tweetLabel.frame.size.width
    }
    

    func retweetClicked() {
        let retweeted = tweet!.isRetweeted! as Bool!
        if (retweeted ?? false) {
            /*
            TwitterClient.sharedInstance.unretweet(tweet.retweetIdStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                }
            })
            */
        } else {
            TwitterClient.sharedInstance.retweet(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                }
            })
        }
       
    }
    
    func favouriteClicked() {
        println("favourite button touched")
        let favourited = tweet!.isFavourited! as Bool!
        if (favourited ?? false) {
            TwitterClient.sharedInstance.unfavourite(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                }
            })
        } else {
            TwitterClient.sharedInstance.favourite(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                }
            })
        }
    }

}
