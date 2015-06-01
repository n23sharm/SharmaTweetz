//
//  MentionsViewController.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/31/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var mentionTweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        TwitterClient.sharedInstance.mentions({ (tweets, error) -> () in
            self.mentionTweets = tweets
            self.tableView.reloadData()
        })
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if mentionTweets != nil {
            return mentionTweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        let currentTweet = mentionTweets[indexPath.row]
        cell.tweet = currentTweet
        return cell
    }

}
