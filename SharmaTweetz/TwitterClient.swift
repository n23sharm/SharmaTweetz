//
//  TwitterClient.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

let twitterConsumerKey = "xmrmJXywoM1gKLHSWmLZ7TuE0"
let twitterConsumerSecret = "2y3fDviKUGmmVc3ele3DsVVe2XNK8kiYb8yG8C5uYN3Wv3KxYx"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)

        }
        return Static.instance
    }
    
    func tweet(status: String!, completion: (Tweet?, error: NSError?) -> ()) {
        var params = ["status":status]
        
        POST("1.1/statuses/update.json", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                println("success in tweeting!")
                completion(response as? Tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("failed in tweeting!")
                completion(nil, error: error)
        })
    }
    
    func retweet(id: String!, completion: (Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id).json", parameters: id,
            success: { (operation:AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweet = Tweet.tweetsWithObject(response as! NSDictionary)
             //   completion(tweet, error: nil)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                completion(nil, error: error)
        })
    
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: ([Tweet]?, error: NSError?) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                completion(tweets, error: nil)
            },
            failure: { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                println("error getting home timeline")
                completion(nil, error: error)
        })
        
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        // Fetch request token and redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "sharmatweetz://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token")
            var authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
        }) { (error: NSError!) -> Void in
                println("Error getting the access token")
            self.loginCompletion?(user: nil, error: error)
        }
        
    }
    
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken:BDBOAuth1Credential(queryString: url.query), success: { (accessToken:BDBOAuth1Credential! ) -> Void in
            println("success getting access token")
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                success:{ (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    println("user: \(user.name)")
                    self.loginCompletion?(user: user, error: nil)
                    
                },
                failure: { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("error getting current user")
                    self.loginCompletion?(user: nil, error: error)
            })

            
            
            }) { (error: NSError!) -> Void in
                println("error getting access token")
                self.loginCompletion?(user: nil, error: error)
        }

    }
   
}
