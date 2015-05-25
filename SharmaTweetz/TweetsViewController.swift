//
//  TweetsViewController.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Fetching Tweets")
        self.refreshControl.addTarget(self, action: "fetchTweets:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)

        let colour = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = colour
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navigationController?.navigationBar.topItem?.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        fetchTweets(self)
    }
    
    func fetchTweets(sender:AnyObject) {
        // Eventually want to do Tweet.homeTimelineWithParams
        TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
      //  cell.replyImageView.addTarget(self, action: "showReplyAlert", forControlEvents:UIControlEvents.TouchUpInside)
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = self.tableView.indexPathForCell(cell)
        
        let tweet = tweets![indexPath!.row] as Tweet
        
        let navigationController = segue.destinationViewController as! UINavigationController
        let tweetDetailsViewController = navigationController.topViewController as! TweetDetailsViewController

        tweetDetailsViewController.tweet = tweet
    }
    
    func showReplyDialog() {
        println("reply button touched")
        var alert : UIAlertController = UIAlertController(title: "Alert", message: "Something got wrong", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "One", style: UIAlertActionStyle.Default, handler: { (alertAction:UIAlertAction!) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }


}
