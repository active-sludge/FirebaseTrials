//
//  RegisterViewController.swift
//  LoodosCase
//
//  Created by Can on 8.12.2021.
//


import UIKit
import Firebase
import FirebaseAnalytics

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
       
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //Navigate to the ChatViewController
                    Analytics.setUserProperty(email, forName: "email")
                    Analytics.logEvent(AnalyticsEventSignUp, parameters: [
                        AnalyticsParameterSuccess: 1,
                    ])
                    self.performSegue(withIdentifier: K.registerSegue, sender: self)
                }
            }
        }
    }
}
