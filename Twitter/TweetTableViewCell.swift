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
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 10

        // Configure the view for the selected state
    }

}
