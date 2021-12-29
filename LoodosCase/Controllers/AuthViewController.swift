//
//  AuthViewController.swift
//  LoodosCase
//
//  Created by Can on 8.12.2021.
//

import UIKit
import Firebase

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    private let appNameConfigKey = "app_name"
    private var remoteConfig: RemoteConfig!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        fetchConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRemoteConfig()
        Analytics.setUserID(UUID().uuidString)
    }
    
    private func displayAppName() {
        let appName = remoteConfig[appNameConfigKey].stringValue
        titleLabel.text = appName
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
        titleLabel.text = remoteConfig[appNameConfigKey].stringValue
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
            self.displayAppName()
        }
    }
}

