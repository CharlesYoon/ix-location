//
//  LoginViewController.swift
//  ixLocation
//
//  Created by Miki von Ketelhodt on 2017/06/13.
//  Copyright © 2017 RBG Applications. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import FirebaseAuth

class LoginViewController: UIViewController, LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let accessToken = AccessToken.current

        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.delegate = self
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (AccessToken.current?.authenticationToken)!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
            print("Firebase logged in")
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let email = user.email
                let photoURL = user.photoURL
                // ...
            } else {
                // user not authenticated
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        // Logged out
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
