//
//  Tweet.swift
//  SharmaTweetz
//
//  Created by Neha Sharma on 5/23/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favouriteCount: Int?
    var isRetweeted: Boolean?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        retweetCount = dictionary["retweet_count"] as? Int
        favouriteCount = dictionary["favorite_count"] as? Int
        isRetweeted = dictionary["retweeted"] as? Boolean
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    class func tweetsWithObject(tweetObject: NSDictionary) -> [Tweet] {
        var tweets = [Tweet]()
        
        /*
        for tweet in tweets {
            if (tweetObject[id] == tweet[id]) {
                tweets.rem
            }
            tweets.append(Tweet(dictionary: dictionary))

        }*/
        
        return tweets
    }
}
