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
    var isRetweeted: Bool?
    var idStr: String?
    var retweetIdStr: String?
    var isFavourited: Bool?
    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        
        retweetCount = dictionary["retweet_count"] as? Int
        favouriteCount = dictionary["favorite_count"] as? Int
        isRetweeted = dictionary["retweeted"] as? Bool
        isFavourited = dictionary["favorited"] as? Bool
        
        idStr = dictionary["id_str"] as? String
        
        let retweetedStatus = dictionary["retweeted_status"] as? NSDictionary
        retweetIdStr = retweetedStatus?["id_str"] as? String
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }
    
    class func tweetWithObject(tweetObject: NSDictionary) -> Tweet {
        return Tweet(dictionary: tweetObject)
    }
}
