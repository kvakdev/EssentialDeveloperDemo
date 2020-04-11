//
//  BaseVC.swift
//  EssentialDeveloperDemo
//
//  Created by Andre Kvashuk on 4/11/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

class BaseVC<T: PViewModel>: UIViewController, ViewSettable, Deinitable, ErrorPresentable {
    // MARK: - Properties
    var name: String {
        let name = String(describing: type(of: self)).components(separatedBy: "<").first ?? ""
        return name
    }
    var titleKey: String = ""
    let disposeBag = DisposeBag()
    
    var viewModel: T? {
        didSet { didSetViewModel() }
        willSet { willSetViewModel() }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    private var _needSetBottomInset: Bool = true
    /// Property ErrorPresentable protocol. For setting using setBottomInset(_ value: CGFloat)
    var bottomInset: CGFloat = 0
    var needKeyboardCheck: Bool { true }
    // MARK: - Init
    init() {
        super.init(nibName: String(describing: type(of: self)).components(separatedBy: "<").first ?? "", bundle: Bundle.main)
        registerNotifications()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - DeInit
    deinit {
        deinitable()
        NotificationCenter.default.removeObserver(self)
    }
    // MARK: - Life cycle
    override func viewDidLoad() {
        guard let viewModel = viewModel else { fatalError("viewModel not exist") }
        viewModel.viewDidLoad()
        viewModel.events.subscribe(onNext: { [weak self] (value) in
            self?.events(value)
        }).disposed(by: disposeBag)
        setup()
        styleSettings()
        addButtonTarget()
        setupCallBacks()
        setBond()
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.viewWillAppear()
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        viewModel?.viewDidAppear()
        setNeedsStatusBarAppearanceUpdate()
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.viewWillDisappear()
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.viewDidDisappear()
        super.viewDidDisappear(animated)
    }
    func willSetViewModel() {}
    func didSetViewModel() {}
    /// Common setup, first call in viewDidLoad
    func setup() {}
    /// Common style setup, call in viewDidLoad after `setup`
    func styleSettings() {}
    /// Common add button targets, call in viewDidLoad after `styleSettings`
    func addButtonTarget() {}
    /// Common setup subscribe on events, call in viewDidLoad after `addButtonTarget`
    func setupCallBacks() {}
    /// Common setup ui elements bond, call in viewDidLoad after `setupCallBacks`
    func setBond() {}
    /// Call did change application language
    func didUpdateLocalization() {}
    /// Event handler
    ///
    /// Default emplimentation handle .back, .backToRoot and .dismiss events. Call super if needed
    ///
    /// - Parameter event: Event to be handled
    func events(_ event: BaseUIEvents) {
        switch event {
        case .back:
            self.navigationController?.popViewController(animated: true)
        case .backToRoot:
            self.navigationController?.popToRootViewController(animated: true)
        case .dismiss(let animate, let completion):
            self.dismiss(animated: animate, completion: completion)
        case .localize:
            updateLocalization()
        default: break
        }
    }
    /// Called when localization is changed
    func updateLocalization() {}
    /// Add constraint to main and sub views
    ///
    /// - Parameters:
    ///   - mainView: UIView
    ///   - subView: UIView
    func addConstraint(_ mainView: UIView, subView: UIView) {
        mainView.addConstraints(subview: subView)
    }
    // MARK: - Notifications -
    // Call this method somewhere in your view controller setup code.
    private func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidChange(_:)), name: UIResponder.keyboardDidChangeFrameNotification, object: nil)
    }
    /// Keyboard was shown. Called when the UIKeyboardDidShowNotification is sent.
    ///
    /// - Parameter notification: Notification
    @objc func keyboardWillShow(_ notification: Notification) { }
    /// Keyboard will be hidden. Called when the UIKeyboardWillHideNotification is sent
    ///
    /// - Parameter notification: Notification
    @objc func keyboardWillHide(_ notification: Notification) { }
    /// Keyboard will be change frame. Called when the UIKeyboardWillHideNotification is sent
    ///
    /// - Parameter notification: Notification
    @objc func keyboardWillChange(_ notification: Notification) { }
    /// Keyboard did be change frame. Called when the UIKeyboardWillHideNotification is sent
    ///
    /// - Parameter notification: Notification
    @objc func keyboardDidChange(_ notification: Notification) { }
    /// Set button height if view have bottom button. Set in viewDidAppear.
    ///
    /// - Parameter value: CGFloat
    func setBottomInset(_ value: CGFloat) {
        guard _needSetBottomInset else { return }
        bottomInset = value
    }
    /// Get height animation duration keyboard from Notification
    ///
    /// - Parameter notification: Notification
    /// - Returns: optional (CGFloat, TimeInterval)
    func getHeightKeyboardWithAnimationDuration(_ notification: Notification) -> (CGFloat, TimeInterval)? {
        return UIResponder.getHeightKeyboardWithAnimationDuration(notification)
    }
    /// Animate bottom constraint
    ///
    /// - Parameters:
    ///   - constraint: NSLayoutConstraint
    ///   - notification: Notification
    ///   - constant: optional CGFloat
    func animateBottomConstraint(_ constraint: NSLayoutConstraint, notification: Notification, constant: CGFloat? = nil) {
        let prevConstant = constraint.constant
        guard let str = KeyboardAnimationProperties(notification) else { return }
        let newConstant = constant ?? str.height
        guard prevConstant != newConstant else { return } // To avoid text field text jumping
        UIView.animate(withDuration: str.animationDuration) {
            constraint.constant = newConstant
            self.view.layoutIfNeeded()
        }
    }
}
