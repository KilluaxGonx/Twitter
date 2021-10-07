//
//  LoginViewController.swift
//  Twitter
//
//  Created by Recleph Mere on 10/6/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "authenticated") {
            
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }
    }
    
    @IBAction func onLoginButtonClick(_ sender: Any) {
        
        let apiURL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: apiURL, success: {
            
            UserDefaults.standard.set(true, forKey: "authenticated")
            self.performSegue(withIdentifier: "LoginToHome", sender: self)
        }, failure: { (Error) in
            print("Could not Login")
        })
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
