//
//  WarningView.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit

final class SBWarningView: UIView, PSBWarningView {
    // MARK: Constants
    private let _constraintBottomKey: String = "kConstraintBottomKey"
    private let _keyboardClassKey: String = "UIRemoteKeyboardWindow"
    private let _defaultDuration: Double = 0.25
    private let _timeLife: TimeInterval = 5
    private let _insets: UIEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    private let _labelInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    // MARK: Properties
    private var _label: UILabel
    private var _imageView: UIImageView
    private var _type: WarningType
    private var _timer: Timer?
    private var _onTabBar: Bool

    private var _bottomInset: CGFloat
    private var _safeAreaBottomInsets: CGFloat {
        if #available(iOS 11.0, *) {
            guard !_onTabBar else { return 0 }
            return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        }
        return 0
    }
    // MARK: Constraints
    private var _imageWidthConstraint: NSLayoutConstraint?
    private var _imageLabelConstraint: NSLayoutConstraint?
    private var _topLabelConstraint: NSLayoutConstraint?
    private var _bottomLabelConstraint: NSLayoutConstraint?
    private var _bottomImageConstraint: NSLayoutConstraint?
    // MARK: Init
    init(_ title: String, type: WarningType, bottomInset: CGFloat, onTabBar: Bool) {
        _onTabBar = onTabBar
        _type = type
        _label = UILabel()
        _label.text = title
        _label.isUserInteractionEnabled = false
        _imageView = UIImageView()
        _bottomInset = bottomInset
        super.init(frame: CGRect.zero)
        common()
    }
    required init?(coder aDecoder: NSCoder) { fatalError("SBWarningView: init(coder:) has not been implemented") }
    // MARK: Deinit
    deinit {
        deinitable()
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: Public functions
    /// Set title
    ///
    /// - Parameter title: String
    func setTitle(_ title: String) {
        _label.text = title
    }
    /// Set font
    ///
    /// - Parameter font: UIFont
    func setFont(_ font: UIFont) {
        _label.font = font
    }
    /// Set text color for title label
    ///
    /// - Parameter color: UIColor
    func setTextColor(_ color: UIColor) {
        _label.textColor = color
    }
    /// Set typ warning view
    ///
    /// - Parameter type: WarningType
    func setType(_ type: WarningType) {
        _type = type
        setupStyle(_type)
    }
    /// Update timer
    func updateTimer() {
        _timer?.invalidate()
        _timer = nil
        _timer = Timer.scheduledTimer(withTimeInterval: _timeLife, repeats: false, block: { [weak self] _ in
            self?.hideWarning()
        })
    }
    /// Show with animation view
    func show() {
        setupStyle(_type)
        superview?.layoutIfNeeded()
        guard let bottomConstraint = getBottomConstraint() else { return }
        let height = bounds.height
        bottomConstraint.constant -= height
        Timer.scheduledTimer(withTimeInterval: 0.01, repeats: false) { [weak self] (timer) in
            timer.invalidate()
            guard let duration = self?._defaultDuration else { return }
            UIView.animate(withDuration: duration) { [weak self] in
                self?.alpha = 1
                bottomConstraint.constant += height
                self?.superview?.layoutIfNeeded()
            }
        }
    }
    /// Hide warning animated
    func hideWarning() {
        _timer?.invalidate()
        _timer = nil
        guard let constraint = getBottomConstraint() else { return }
        UIView.animate(withDuration: _defaultDuration, animations: { [weak self] in
            constraint.constant -= (self?.bounds.height ?? 0)
            self?.alpha = 0
            self?.superview?.layoutIfNeeded()
        }) { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    /// Add constraints to view at bottom inset
    func addConstraintsToView(needKeyboardHeight: Bool) {
        let keyboardHeight = needKeyboardHeight ? UIResponder.getKeyboardHeigh() : 0
        var inset = keyboardHeight == 0 ? _bottomInset : _bottomInset + keyboardHeight
        inset += _bottomInset == 0 ? 0 : _safeAreaBottomInsets
        inset -= keyboardHeight > 0 && _bottomInset > 0 ? _safeAreaBottomInsets : 0
        //
        guard let _superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: _superView.leadingAnchor, constant: 0).isActive = true
        _superView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        //
        let bottom = _superView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: inset)
        bottom.isActive = true
        bottom.identifier = _constraintBottomKey
        guard keyboardHeight != 0 else { return }
        guard let value = _bottomLabelConstraint?.constant, value > _insets.bottom else { return }
        _bottomLabelConstraint?.constant -= _safeAreaBottomInsets
        _bottomImageConstraint?.constant -= _safeAreaBottomInsets
    }
    // MARK: Private functions
    private func common() {
        _label.numberOfLines = 0
        _imageView.contentMode = .scaleAspectFit
        addSubview(_imageView)
        addSubview(_label)
        
        setupStyle(_type)
        addConstraintsToViews()
        registerForKeyboardNotifications()
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeGesture.direction = .down
        self.addGestureRecognizer(swipeGesture)
    }
    @objc
    private func swipe() {
        if _timer != nil { hideWarning() }
    }
    /// Add constraints to inside views (UILabel and UIImageView)
    private func addConstraintsToViews() {
        _label.translatesAutoresizingMaskIntoConstraints = false
        _imageView.translatesAutoresizingMaskIntoConstraints = false
        //
        _imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: _insets.left).isActive = true
        _imageView.topAnchor.constraint(equalTo: topAnchor, constant: _insets.top).isActive = true
        //
        _imageWidthConstraint = _imageView.widthAnchor.constraint(equalToConstant: 0)
        _imageWidthConstraint?.isActive = true
        //
        _imageLabelConstraint = _label.leadingAnchor.constraint(equalTo: _imageView.trailingAnchor, constant: 0)
        _imageLabelConstraint?.isActive = true
        
        trailingAnchor.constraint(equalTo: _label.trailingAnchor, constant: _insets.right).isActive = true
        _topLabelConstraint = _label.topAnchor.constraint(equalTo: topAnchor, constant: _insets.top)
        _topLabelConstraint?.isActive = true
        
         let bottomInset = _bottomInset == 0 ? _insets.bottom + _safeAreaBottomInsets : _insets.bottom
        _bottomLabelConstraint = bottomAnchor.constraint(equalTo: _label.bottomAnchor, constant: bottomInset)
        _bottomLabelConstraint?.isActive = true
        
        _bottomImageConstraint =  bottomAnchor.constraint(equalTo: _imageView.bottomAnchor, constant: bottomInset)
        _bottomImageConstraint?.isActive = true
    }
    
    /// Setup view colors
    private func setupStyle(_ type: WarningType) {
        _imageWidthConstraint?.constant = 0
        _imageLabelConstraint?.constant = 0
        _imageView.image = nil
        _label.textColor = .white
        _label.textAlignment = .left
        _label.font = UIFont.systemFont(ofSize: 17)
        switch type {
        case .error:
            backgroundColor = ._EB5757
            _label.textAlignment = .center
        case .warning(let value):
            backgroundColor = ._F2994A
            _imageWidthConstraint?.constant = 33.5
            _imageLabelConstraint?.constant = 12
            switch value {
            case .connection:
                _imageView.image = UIImage()
            case .server:
                _imageView.image = UIImage()
            }
        case .info(let value):
            if value != .orange {
                _label.textAlignment = .center
                _topLabelConstraint?.constant = _labelInsets.top
                let bottomInset = _bottomInset == 0 ? _labelInsets.bottom + _safeAreaBottomInsets : _labelInsets.bottom
                _bottomLabelConstraint?.constant = bottomInset
            }
            setupStyleInfo(value)
        }
    }
    /// Setup style for info cases
    ///
    /// - Parameter value: WarningType.ErrorPresentableInfoColors
    private func setupStyleInfo(_ value: WarningType.ErrorPresentableInfoColors) {
        switch value {
        case .gray:
            backgroundColor = ._333333
        case .green:
            backgroundColor = ._31AD55
        case .red:
            backgroundColor = ._EB5757
        case .orange:
            backgroundColor = ._F2994A
        }
    }
    /// Register for keyboard notifications
    private func registerForKeyboardNotifications() {
        let showName: NSNotification.Name = UIResponder.keyboardWillShowNotification
        let hideName: NSNotification.Name = UIResponder.keyboardWillHideNotification
        let nCenter = NotificationCenter.default
        nCenter.addObserver(self, selector: #selector(keyboardWasShow(_:)), name: showName, object: nil)
        nCenter.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: hideName, object: nil)
    }
 
    @objc
    /// Keyboard was shown
    ///
    /// - Parameter notification: Notification
    private func keyboardWasShow(_ notification: Notification) {
        guard let tuple = UIResponder.getHeightKeyboardWithAnimationDuration(notification) else { return }
        var height = tuple.0
        if #available(iOS 11, *) {
            height += _safeAreaBottomInsets
            if _bottomInset >= 0 { height += _bottomInset }
            if _onTabBar { height -= getHeighTabbar() }
        }
        changeBottomInset(height, duration: tuple.1, labelBottomInset: _insets.bottom)
    }
    @objc
    /// Keyboard will be hidden
    ///
    /// - Parameter notification: Notification
    private func keyboardWillBeHidden(_ notification: Notification) {
        guard let tuple = UIResponder.getHeightKeyboardWithAnimationDuration(notification) else { return }
        changeBottomInset(tuple.0, duration: tuple.1, labelBottomInset: _insets.bottom)
        let labelBottomInset = _bottomInset == 0 ? _insets.bottom + _safeAreaBottomInsets : _insets.bottom
        changeBottomInset(_bottomInset, duration: tuple.1, labelBottomInset: labelBottomInset)
    }
    /// Get bottom constraint
    ///
    /// - Returns: optional NSLayoutConstraint
    private func getBottomConstraint() -> NSLayoutConstraint? {
        let filteredConstraints = superview?.constraints.filter { $0.identifier == _constraintBottomKey }
        guard let constraint = filteredConstraints?.first else { return nil }
        return constraint
    }
    /// Change bottom inset animation
    ///
    /// - Parameters:
    ///   - inset: CGFloat
    ///   - duration: optional Double
    private func changeBottomInset(_ inset: CGFloat, duration: Double?, labelBottomInset: CGFloat) {
        guard let constraint = getBottomConstraint() else { return }
        UIView.animate(withDuration: duration ?? _defaultDuration, animations: { [weak self] in
            guard let _self = self else { return }
            constraint.constant = inset
            self?._bottomLabelConstraint?.constant = labelBottomInset
            _self.superview?.layoutIfNeeded()
        })
    }
    
    private func getHeighTabbar() -> CGFloat {
        if let tabBarController = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController {
            return tabBarController.tabBar.frame.height
        } else {
            return 0
        }
    }
}
