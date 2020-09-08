//
//  AlertViewConfig.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 27/05/20.
//

import Foundation

public struct AlertViewConfig {
    
    // MARK: - Properties
    public var image: UIImage?
    public var title: String?
    public var attributedDescription: NSAttributedString?
    public var textAlign: NSTextAlignment = .center
    public var tapDismiss: Bool = true
    public var cancelButtonTitle: String?
    public var doneButtonTitle: String?
    public var enableVibrate: Bool = true
    public var cancelAction: AlertCancelAction?
    public var doneAction: AlertDoneAction?
    
    public var titleColorButtonDone: UIColor = .white
    public var backgroundColorButtonDone = UIColor(red: 0.03, green: 0.31, blue: 0.62, alpha: 1)
    
    public var titleColorButtonCancel: UIColor = .white
    public var backgroundColorButtonCancel = UIColor.red
    
    // MARK: - Public Methods
    public init() {
        // Intentionally unimplemented...
    }
    
}
