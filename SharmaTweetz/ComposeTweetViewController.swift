//
//  ComposeTweetViewController.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/24/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    
    var statusText: String!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = User.currentUser
        nameLabel.text = user!.name
        usernameLabel.text = user!.screenname
        profileImageView.setImageWithURL(user?.profileImageUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func updateStatusText(sender: AnyObject) {
        statusText = statusTextField.text 
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        TwitterClient.sharedInstance.tweet(statusText, completion: { (tweet, error) -> () in
            
        })
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
