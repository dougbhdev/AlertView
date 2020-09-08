//
//  AlertViewDelegate.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 26/05/20.
//

import Foundation

public typealias AlertDoneAction = (() -> Void)
public typealias AlertCancelAction = (() -> Void)

public protocol AlertViewProtocol {
    
    func show(config: AlertViewConfig,
              doneAction: AlertDoneAction?,
              cancelAction: AlertCancelAction?)
    
}
