//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Recleph Mere on 10/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    
    @IBOutlet weak var displayName: UILabel!
    
    
    @IBOutlet weak var tweet: UILabel!
    
   
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetID:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onFavTweetClick(_ sender: Any) {
        let toBeFavorited = !favorited
        
        if(toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorited(true)
            }, failure: { (Error) in
                print("Failed to favorite Tweet!: \(Error)")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorited(false)
            }, failure: { (Error) in
                print("Failed to favorite Tweet!: \(Error)")
            })
        }
        
    }
    
    

    @IBAction func onRetweetButtonClick(_ sender: Any) {
    
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Failed to retweet: \(Error)")
        })
    }
    
    func setFavorited(_ isFavorited:Bool) {
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
        
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 10

        // Configure the view for the selected state
    }

}
