//
//  AlertView.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 24/05/20.
//

import Foundation

extension CustomAlertView: AlertViewProtocol {
    
    public func show(config: AlertViewConfig,
                     doneAction: AlertDoneAction? = nil,
                     cancelAction: AlertCancelAction? = nil) {
        
        let alert = CustomAlertView()
        
        alert.configureAlert(with: config)
        alert.actionCallback(done: doneAction, cancel: cancelAction)
        
        DispatchQueue.global().sync {
            alert.show(animated: true, alpha: 0.4, vibrate: config.enableVibrate)
        }
    }
    
}
