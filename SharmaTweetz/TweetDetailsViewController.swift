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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
