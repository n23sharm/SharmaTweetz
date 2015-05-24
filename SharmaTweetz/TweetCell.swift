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
            
            let retweeted = tweet.isRetweeted as Boolean!
            if (retweeted != nil) {
                self.retweetImageView.image = UIImage(contentsOfFile: "retweet_on.png")
            } else {
                self.retweetImageView.image = UIImage(named: "retweet_default.png")
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func replyClicked() {
        println("reply button touched")
    }
    
    func retweetClicked() {
        println("retweet button touched")
    }
    
    func favouriteClicked() {
        println("favourite button touched")
    }

}
