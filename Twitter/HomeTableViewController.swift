//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Recleph Mere on 10/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweets = [NSDictionary]()
    var numofTweets: Int!
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()
        myRefreshControl.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = myRefreshControl

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @objc func loadTweets() {
        
        numofTweets = 10
        let apiURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let apiParameters = ["count": numofTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: apiURL, parameters: apiParameters as [String : Any], success: { (tweetArray: [NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweetArray {
                self.tweets.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets!")
        })
        
    }

    
    func loadMoreTweets() {
        
        let apiURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let apiParameters = ["count": numofTweets + 5]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: apiURL, parameters: apiParameters, success: { (tweetArray: [NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweetArray {
                self.tweets.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets!")
        })
        
    }
    
    @IBAction func onLogoutButtonClick(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "authenticated")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        let user = tweet["user"] as! NSDictionary
        let profileURL = URL(string: ((user["profile_image_url_https"] as? String)!))
        let data = try? Data(contentsOf: profileURL!)
        
        cell.tweet.text = tweet["text"] as? String
        cell.displayName.text = user["name"] as? String
        
        if let imageData = data {
            
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count {
            loadMoreTweets()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweets.count
    }

}
