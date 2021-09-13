//
//  LoadingView.swift
//  ByteCoin
//
//  Created by Darshil Agrawal on 13/09/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//


import UIKit
import Lottie

class LoadingView: UIView {
    @IBOutlet weak var loadingAnimationView: AnimationView!
    static let instance: LoadingView = {
        let bundle = Bundle(for: LoadingView.self)
        let nib = UINib(nibName: String(describing: LoadingView.self), bundle: bundle)
        let view = nib.instantiate(withOwner: nil, options: nil).first as! LoadingView

        return view
    }()
    
    func show(){
        if let vc = Utility.getVisibleViewController(){
            let view = vc.view!
            view.backgroundColor = .black
            if !self.isDescendant(of: view)
            {
                view.addSubview(self)
                loadingAnimationView.backgroundColor = .black
                loadingAnimationView.loopMode = .loop
                loadingAnimationView.play()
//                Utility.fill(view: self, parent: view)
            }
//            activity.startAnimating()
        }
    }
    
    func hide(){
//        self.activity.stopAnimating()
        loadingAnimationView.stop()
        self.removeFromSuperview()
    }
}


class Utility{
    static func getVisibleViewController( rootViewController: UIViewController? = nil) -> UIViewController? {
        var rootViewController = rootViewController
        if rootViewController == nil {
            rootViewController = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootViewController?.presentedViewController == nil {
            return rootViewController
        }
        
        if let presented = rootViewController?.presentedViewController {
            if presented is UINavigationController {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented is UITabBarController {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            
            return getVisibleViewController(rootViewController: presented)
        }
        return nil
    }
    
    static func fill(view: UIView, parent: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        //left
        NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: parent, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
        
        
        //right
        NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: parent, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
        
        
        //top
        NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        
        
        //bottom
        NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        
        parent.setNeedsLayout()
        parent.layoutIfNeeded()
    }
}
