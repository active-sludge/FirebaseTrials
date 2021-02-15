//
//  Loader.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 15.02.2021.
//

import UIKit

public class Loader {
    private var overlayView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    /// Singleton is used, so that only one instance of loading activity runs at the same time.
    static var instance = Loader()
    
    /// When a the user interaction wanted to be disables, in cases such as loading data, this function can be called. An activity indicator pops up. Starts spinning. The indicator stands in the center of the view.
    /// - Parameter view: Any view that needs user interaction to be disabled.
    public func showOverlayView(view: UIView) {
        DispatchQueue.main.async {
            self.overlayView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            self.overlayView.center = view.center
            self.overlayView.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
            self.overlayView.clipsToBounds = true
            self.overlayView.layer.cornerRadius = 5
            self.overlayView.addSubview(self.activityIndicator)
            
            self.activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            self.activityIndicator.style = .large
            self.activityIndicator.color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.activityIndicator.center = CGPoint(x: self.overlayView.bounds.width / 2, y: self.overlayView.bounds.height / 2)
            
            view.mask = UIView(frame: view.frame)
            view.mask?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            view.isUserInteractionEnabled = false
            
            view.addSubview(self.overlayView)
            self.activityIndicator.startAnimating()
        }
    }
    
    /// Stops the activity indicator and removes mask view. This method must be called after showOverlayView method is called.
    /// - Parameter view: Any view that wants to stop activity indicator..
    public func hideOverlayView(view: UIView) {
        DispatchQueue.main.async {
            view.mask = nil
            view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
            self.overlayView.removeFromSuperview()
        }
    }
}
