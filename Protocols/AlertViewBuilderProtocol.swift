//
//  AlertViewBuilderProtocol.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 27/05/20.
//

import Foundation

protocol AlertViewBuilderProtocol {
    
    func withTitle(_ title: String?) -> AlertViewBuilder
    func withIcon(_ image: UIImage?) -> AlertViewBuilder
    func withMessage(_ message: String?) -> AlertViewBuilder
    func withMessage(_ message: NSAttributedString?) -> AlertViewBuilder
    func withTextAlign(_ alignment: NSTextAlignment) -> AlertViewBuilder
    func withTapDismiss(_ tap: Bool) -> AlertViewBuilder
    func withEnableVibrate(_ enable: Bool) -> AlertViewBuilder
    func withCancelButtonTitle(_ title: String?) -> AlertViewBuilder
    func withDoneButtonTitle(_ title: String?) -> AlertViewBuilder
    
    //custom button
    func withTitleColorButtonDone(_ color: UIColor) -> AlertViewBuilder
    func withBackgroundColorButtonDone(_ color: UIColor) -> AlertViewBuilder
    
    func withTitleColorButtonCancel(_ color: UIColor) -> AlertViewBuilder
    func withBackgroundColorButtonCancel(_ color: UIColor) -> AlertViewBuilder
}
