//
//  WindowView.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 21/05/20.
//

import Foundation
import UIKit

protocol WindowView {
    
    var background: UIView { get }
    var dialogBox: UIView { get set }
    
    func show(animated: Bool, alpha: CGFloat, vibrate: Bool)
    func dismiss(animated: Bool)
    
}

extension WindowView where Self: UIView {
    
    internal func show(animated: Bool,
                       alpha: CGFloat,
                       vibrate: Bool) {
        
        background.alpha = 0.0
        
        if var rootViewController = UIApplication.shared.delegate?.window??.rootViewController {
            while let presentedViewController = rootViewController.presentedViewController {
                rootViewController = presentedViewController
            }
            rootViewController.view.addSubview(self)
        }
        
        if animated {
            transform = CGAffineTransform(scaleX: 1, y: 1)
            positionView()
            
            if vibrate {
                vibrateAlert()
            }
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.background.alpha = alpha
                            
                            self.alpha = 1
                            self.transform = .identity
                            
            }, completion: { _ in
                UIView.transition(with: self,
                                  duration: 0.1,
                                  options: [.transitionCrossDissolve, .curveEaseInOut, .beginFromCurrentState],
                                  animations: {
                                    self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                }, completion: { _ in
                    self.transformIdentity(identity: .identity)
                })
            })
        } else {
            positionView()
        }
    }
    
    internal func transformIdentity(identity: CGAffineTransform) {
        UIView.animate(withDuration: 0.2) {
            self.transform = identity
        }
    }
    
    internal func dismiss(animated: Bool) {
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                            self.background.alpha = 0
            }
            
            UIView.transition(with: self,
                              duration: 0.3,
                              options: [.transitionCrossDissolve, .curveEaseInOut, .beginFromCurrentState],
                              animations: {
                                self.alpha = 0
                                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
                self.removeFromSuperview()
            })
        } else {
            removeFromSuperview()
        }
    }
    
    // MARK: - Private Methods
    
    private func positionView() {
        dialogBox.center = center
    }
    
    private func vibrateAlert() {
        VibrationType.light.vibrate()
    }
}
