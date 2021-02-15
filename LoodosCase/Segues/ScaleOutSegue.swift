//
//  ScaleOutSegue.swift
//  LoodosCase
//
//  Created by Huseyin Can Dayan on 15.02.2021.
//

import UIKit

class ScaleOutSegue: UIStoryboardSegue {
    
    override func perform() {
        scaleOut()
    }
    
    func scaleOut(){
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let originalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = originalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut) {
            toViewController.view.transform = CGAffineTransform.identity
        } completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        }
    }
}
