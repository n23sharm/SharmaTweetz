//
//  TweetDetailsViewController.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/24/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var favouriteCountLabel: UILabel!
    
    var tweet: Tweet!
    var replyTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colour = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = colour
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        let user = tweet.user as User!
        profileImageView.setImageWithURL(user.profileImageUrl)
        nameLabel.text = user.name
        usernameLabel.text = "@" + user.screenname!
        tweetLabel.text = tweet.text
        dateLabel.text = tweet.createdAtString
        
        let retweetCount = tweet.retweetCount!
        let favouriteCount = tweet.favouriteCount!
        retweetCountLabel.text = String(stringInterpolationSegment: retweetCount)
        favouriteCountLabel.text = String(stringInterpolationSegment: favouriteCount)
        
        
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
        
        replyImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "replyClicked"))
        retweetImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "retweetClicked"))
        favouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "favouriteClicked"))

    }
    
    func replyClicked() {
        var alert : UIAlertController = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            
        alert.addAction(UIAlertAction(title: "Reply", style: UIAlertActionStyle.Default, handler:{ (alertAction:UIAlertAction!) -> Void in
            
            let user = self.tweet.user
            let replyStatus = "@\((user?.screenname)!) \((self.replyTextField?.text)!)"
            
            TwitterClient.sharedInstance.reply(replyStatus, replyToId: self.tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.replyImageView.image = nil
                }
            })
            
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler:{ (alertAction:UIAlertAction!) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
            
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
            textField.placeholder = "Write your reply"
            self.replyTextField = textField
        }
            
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func retweetClicked() {
        let retweeted = tweet!.isRetweeted! as Bool!
        if (retweeted ?? false) {
        } else {
            TwitterClient.sharedInstance.retweet(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                    self.retweetImageView.image = UIImage(named: "retweet_on")
                }
            })
        }
    }
    
    func favouriteClicked() {
        let favourited = tweet!.isFavourited! as Bool!
        if (favourited ?? false) {
            TwitterClient.sharedInstance.unfavourite(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                    self.favouriteImageView.image = UIImage(named: "favorite_default")
                }
            })
        } else {
            TwitterClient.sharedInstance.favourite(tweet.idStr, completion: { (tweet, error) -> () in
                if tweet != nil {
                    self.tweet = tweet
                    self.favouriteImageView.image = UIImage(named: "favorite_on")
                }
            })
        }
    }


    @IBAction func onBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
