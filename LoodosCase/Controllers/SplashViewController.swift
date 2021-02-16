//
//  MainViewController.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 14.02.2021.
//

import UIKit
import Firebase
import Network

class SplashViewController: UIViewController {
    
    private let welcomeMessageConfigKey = "welcome_message"
    private let loadingPhraseConfigKey = "loading_phrase"
    private let networkMonitor = NetworkMonitor.shared
    
    private var remoteConfig: RemoteConfig!
    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tryAgainButton.isHidden = true
        setupRemoteConfig()
        checkInternetConnection()
    }
    
    //MARK: - SplashViewController functions
    @IBAction private func tryAgainButtonTapped(_ sender: Any) {
        checkInternetConnection()
    }
    
    private func displayWelcome() {
        let welcomeMessage = remoteConfig[welcomeMessageConfigKey].stringValue
        welcomeLabel.text = welcomeMessage
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.performSegue(withIdentifier: "toMain", sender: self )
        })
    }
    
    private func checkInternetConnection() {
        if networkMonitor.isConnectedToInternet() {
            fetchConfig()
            tryAgainButton.isHidden = true
        } else {
            welcomeLabel.text = "No internet connection"
            tryAgainButton.isHidden = false
        }
    }
    
    //MARK: - RemoteConfig
    private func setupRemoteConfig() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
    }
    
    private func fetchConfig() {
        welcomeLabel.text = remoteConfig[loadingPhraseConfigKey].stringValue
        remoteConfig.fetch() { (status, error) -> Void in
            if status == .success {
                print("Config fetched!")
                self.remoteConfig.activate() { (changed, error) in
                    // ...
                }
            } else {
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            self.displayWelcome()
        }
    }   
}
