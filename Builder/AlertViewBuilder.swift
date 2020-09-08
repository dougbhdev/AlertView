//
//  AlertViewBuilder.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 27/05/20.
//

import Foundation

public class AlertViewBuilder: AlertViewBuilderProtocol {
    
    // MARK: - Properties
    
    private var config: AlertViewConfig
    
    // MARK: - Public Methods
    
    public init() {
        config = AlertViewConfig()
    }
    
    public func withIcon(_ image: UIImage?) -> AlertViewBuilder {
        config.image = image
        return self
    }
    
    public func withTitle(_ title: String?) -> AlertViewBuilder {
        config.title = title
        return self
    }
    
    public func withMessage(_ message: String?) -> AlertViewBuilder {
        guard let message = message else { return self }
        config.attributedDescription = NSAttributedString(string: message)
        return self
    }
    
    public func withMessage(_ message: NSAttributedString?) -> AlertViewBuilder {
        guard let message = message else { return self }
        config.attributedDescription = message
        return self
    }
    
    public func withTextAlign(_ alignment: NSTextAlignment) -> AlertViewBuilder {
        config.textAlign = alignment
        return self
    }
    
    public func withTapDismiss(_ tap: Bool) -> AlertViewBuilder {
        config.tapDismiss = tap
        return self
    }
    
    public func withEnableVibrate(_ enable: Bool) -> AlertViewBuilder {
        config.enableVibrate = enable
        return self
    }
    
    public func withCancelButtonTitle(_ title: String?) -> AlertViewBuilder {
        config.cancelButtonTitle = title
        return self
    }
    
    public func withDoneButtonTitle(_ title: String?) -> AlertViewBuilder {
        config.doneButtonTitle = title
        return self
    }
    
    public func withTitleColorButtonDone(_ color: UIColor) -> AlertViewBuilder {
        config.titleColorButtonDone = color
        return self
    }
    
    public func withBackgroundColorButtonDone(_ color: UIColor) -> AlertViewBuilder {
        config.backgroundColorButtonDone = color
        return self
    }
    
    public func withTitleColorButtonCancel(_ color: UIColor) -> AlertViewBuilder {
        config.titleColorButtonCancel = color
        return self
    }
    
    public func withBackgroundColorButtonCancel(_ color: UIColor) -> AlertViewBuilder {
        config.backgroundColorButtonCancel = color
        return self
    }
    
    public func build() -> AlertViewConfig {
        return config
    }
}
