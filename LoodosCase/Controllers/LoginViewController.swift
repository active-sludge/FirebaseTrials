//
//  LoginViewController.swift
//  LoodosCase
//
//  Created by Can on 8.12.2021.
//


import UIKit
import Firebase
import FirebaseAnalytics

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    Analytics.setUserProperty(email, forName: "email")
                    Analytics.logEvent(AnalyticsEventLogin, parameters: [
                      AnalyticsParameterSuccess: 1
                      ])
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
            }
        }
    }
}
