//
//  CustomAlertView.swift
//  AlertView
//
//  Created by Douglas Henrique Goulart Nunes on 22/05/20.
//

import UIKit

public class CustomAlertView: UIView, WindowView {
    
    // MARK: - Public properties
    
    public var background = UIView()
    public var dialogBox = UIView()
    
    // MARK: - Private properties
    
    private var timer: Timer?
    private var heightStack: CGFloat = 42.0
    private var position: CGFloat = 20.0
    private let margin: CGFloat = 15.0
    
    private var tapDismissScreen: Bool = false
    private var disableDoneButton: Bool = false
    private var actionDoneCallback: AlertDoneAction?
    private var actionCancelCallback: AlertCancelAction?
    
    private lazy var alertImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.tintColor = .blue
        img.clipsToBounds = true
        img.sizeToFit()
        img.accessibilityIdentifier = "alertImageIdentifier"
        return img
    }()
    
    private lazy var alertTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        label.accessibilityIdentifier = "alertTitleIdentifier"
        return label
    }()
    
    private lazy var alertSubTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.accessibilityIdentifier = "alertSubTitleIdentifier"
        return label
    }()
    
    private lazy var alertDoneButton: CustomButton = {
        let button = CustomButton(type: .custom)
        button.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(alertButtonActionDone(_:)), for: .touchUpInside)
        button.accessibilityIdentifier = "alertDoneButtonIdentifier"
        return button
    }()
    
    private lazy var alertCancelButton: CustomButton = {
        let button = CustomButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(alertButtonActionCancel(_:)), for: .touchUpInside)
        button.accessibilityIdentifier = "alertCancelButtonIdentifier"
        return button
    }()
    
    private lazy var stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        
        return stackView
    }()
    
    // MARK: - Init
    
    public convenience init() {
        self.init(frame: UIScreen.main.bounds)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public functions
    
    public func configureAlert(with config: AlertViewConfig) {
        
        configureBackground()
        let dialogViewWidth: CGFloat = frame.width - 60
        tapDismissScreen = config.tapDismiss
        
        func setupImage() {
            guard let image = config.image else { return }
            configImage(image: image, dialogWidth: dialogViewWidth)
        }
        
        func setupTitle() {
            configTitle(title: config.title, dialogWidth: dialogViewWidth)
        }
        
        func setupDescription() {
            configDescription(message: config.attributedDescription, textAlign: config.textAlign, dialogWidth: dialogViewWidth)
        }
        
        func setupCancelButton() {
            configCancelButton(title: config.cancelButtonTitle, titleColor: config.titleColorButtonCancel, backgroundColor: config.backgroundColorButtonCancel)
        }
        
        func setupDoneButton() {
            configDoneButton(title: config.doneButtonTitle, titleColor: config.titleColorButtonDone, backgroundColor: config.backgroundColorButtonDone)
        }
        
        func setupStackButtons() {
            let configStack = getConfigureButtons(buttonCancelTitle: config.cancelButtonTitle, buttonDoneTitle: config.doneButtonTitle, sizeHeightStack: heightStack)
            stack.frame = CGRect(x: margin, y: position, width: dialogViewWidth - (margin * 2), height: configStack.sizeStack)
            dialogBox.addSubview(stack)
            position = stack.frame.maxY + 15
        }
        
        let parameters: [Any?] = [config.image, config.title, config.attributedDescription, config.cancelButtonTitle, config.doneButtonTitle]
        let functions = [setupImage, setupTitle, setupDescription, setupCancelButton, setupDoneButton]
        _ = parameters.enumerated().map { index, element in
            if element != nil {
                functions[index]()
            }
        }
        setupStackButtons()
        createDialog(position: position)
    }
    
    public func actionCallback(done: AlertDoneAction? = nil, cancel: AlertCancelAction? = nil) {
        actionDoneCallback = done
        actionCancelCallback = cancel
    }
    
    // MARK: - Private functions
    
    /// Set position buttons
    ///
    /// - Parameters:
    ///   - buttonCancelTitle: Action button Cancel
    ///   - buttonDoneTitle: Action button title
    ///   - sizeHeightStack: size of the StackView
    private func getConfigureButtons(buttonCancelTitle: String? = nil,
                                     buttonDoneTitle: String? = nil,
                                     sizeHeightStack: CGFloat) -> (totalCaracters: Int, sizeStack: CGFloat) {
        
        guard let done = buttonDoneTitle else {
            return(0, sizeHeightStack)
        }
        if done.count > 11 && (buttonCancelTitle != nil) {
            stack.axis = .vertical
            heightStack = (sizeHeightStack * 2)
            
            stack.insertArrangedSubview(alertDoneButton, at: 0)
            stack.insertArrangedSubview(alertCancelButton, at: 1)
        }
        return (done.count, heightStack)
    }
    
    private func configImage(image: UIImage,
                             dialogWidth: CGFloat) {
        alertImage.image = image
        alertImage.center = CGPoint(x: (dialogWidth / 2) - ((image.size.width) / 2), y: position + 10)
        dialogBox.addSubview(alertImage)
        position = alertImage.frame.maxY + 17
    }
    
    private func configTitle(title: String?,
                             dialogWidth: CGFloat) {
        
        guard let title = title else { return }
        
        let font = UIFont.systemFont(ofSize: 18, weight: .medium)
        let heightLabel = heightForView(text: NSAttributedString(string: title), font: font, width: dialogWidth - (margin * 2))
        alertTitle.frame = CGRect(x: margin, y: position, width: dialogWidth - (margin * 2), height: heightLabel + 5)
        
        alertTitle.text = title
        dialogBox.addSubview(alertTitle)
        position = alertTitle.frame.maxY + 5
    }
    
    private func configDescription(message: NSAttributedString?,
                                   textAlign: NSTextAlignment,
                                   dialogWidth: CGFloat) {
        
        guard let message = message else { return }
        
        let font = UIFont.systemFont(ofSize: 15)
        let heightLabel = heightForView(text: message, font: font, width: dialogWidth - (margin * 4))
        alertSubTitle.frame = CGRect(x: margin * 2, y: position, width: dialogWidth - (margin * 4), height: heightLabel + 10)
        alertSubTitle.attributedText = message
        
        alertSubTitle.textAlignment = textAlign
        dialogBox.addSubview(alertSubTitle)
        position = alertSubTitle.frame.maxY + 10
    }
    
    private func configCancelButton(title: String?,
                                    titleColor: UIColor,
                                    backgroundColor: UIColor) {
        guard let title = title else { return }
        
        alertCancelButton.setTitle(title, for: .normal)
        alertCancelButton.tintColor = titleColor
        alertCancelButton.backgroundColor = backgroundColor
        stack.addArrangedSubview(alertCancelButton)
    }
    
    private func configDoneButton(title: String?,
                                  titleColor: UIColor,
                                  backgroundColor: UIColor) {
        
        guard let title = title else { return }
        alertDoneButton.setTitle(title, for: .normal)
        alertDoneButton.tintColor = titleColor
        alertDoneButton.backgroundColor = backgroundColor
        stack.addArrangedSubview(alertDoneButton)
        alertDoneButton.isEnabled = !disableDoneButton
    }
    
    private func createDialog(position: CGFloat) {
        dialogBox.clipsToBounds = true
        dialogBox.accessibilityIdentifier = "customAlertViewDialogBoxIdentifier"
        dialogBox.frame.origin = CGPoint(x: 28, y: frame.height)
        dialogBox.frame.size = CGSize(width: frame.width - 56, height: position)
        dialogBox.backgroundColor = .white
        dialogBox.layer.cornerRadius = 5
        addSubview(dialogBox)
        
    }
    
    private func configureBackground() {
        background.frame = frame
        background.backgroundColor = .black
        background.alpha = 0.6
        background.accessibilityIdentifier = "customAlertViewBackgroundIdentifier"
        background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(background)
    }
    
    private func heightForView(text: NSAttributedString,
                               font: UIFont,
                               width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.attributedText = text
        label.sizeToFit()
        return label.frame.height
    }
    
    private func dismissAlert(animated: Bool) {
        if let timer = timer {
            timer.invalidate()
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
            self.dismiss(animated: animated)
        }
        
    }
    
    @objc
    private func didTappedOnBackgroundView() {
        if tapDismissScreen {
            dismiss(animated: true)
        }
    }
    
    @objc
    private func alertButtonActionDone(_ sender: Any) {
        actionDoneCallback?()
        dismissAlert(animated: true)
    }
    
    @objc
    private func alertButtonActionCancel(_ sender: Any) {
        actionCancelCallback?()
        dismissAlert(animated: true)
    }
    
}
