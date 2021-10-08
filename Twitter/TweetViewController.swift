//
//  TweetViewController.swift
//  Twitter
//
//  Created by Recleph Mere on 10/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    
    @IBOutlet weak var statusTextView: UITextView!
    
    @IBAction func onCancelButtonClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onConfirmButtonClick(_ sender: Any) {
        
        if(!statusTextView.text.isEmpty && statusTextView.text.count < 280) {
            

            TwitterAPICaller.client?.postStatusUpdate(tweetString: statusTextView.text, success: {
                
                self.dismiss(animated: true, completion: nil);
                
            }, failure: { (Error) in
                print("Error ON Posting: Could not send tweet - \(Error)")
                self.onCancelButtonClick(self)
            })
        } else {
            statusTextView.layer.borderColor = UIColor.red.cgColor
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        statusTextView.becomeFirstResponder()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
