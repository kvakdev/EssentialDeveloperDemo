//
//  RequisiteCell.swift
//  EssentialDeveloperDemoTests
//
//  Created by Andre Kvashuk on 4/20/20.
//  Copyright © 2020 Andre Kvashuk. All rights reserved.
//

import UIKit
import RxSwift

public class RequisiteCell: UITableViewCell {
    let inputTextField = UITextField()
    let errorLabel = UILabel()
    let cellTitleLabel = UILabel()
    let button = UIButton()
    
    private var vm: RequisitesCellViewModelProtocol?
    private var _viewModelBag = DisposeBag()
    private let _uiDisposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        _viewModelBag = DisposeBag()
    }
    
    func setup() {
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellTitleLabel)
        let titleLabelConstraints = [
            cellTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            cellTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cellTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            cellTitleLabel.heightAnchor.constraint(equalToConstant: 16)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        inputTextField.keyboardType = .default
        inputTextField.inputAccessoryView = nil
        inputTextField.borderStyle = .roundedRect
        inputTextField.delegate = self
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(inputTextField)
        let textFieldConstraints = [
            inputTextField.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            inputTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            inputTextField.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor, constant: 16),
            inputTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(textFieldConstraints)
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(errorLabel)
        let errorLabelConstraints = [
            errorLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor, constant: 2),
            errorLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            errorLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            errorLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(errorLabelConstraints)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        let buttonConstraints = [
            button.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            button.leftAnchor.constraint(equalTo: leftAnchor),
            button.rightAnchor.constraint(equalTo: rightAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        
        self.inputTextField.rx.controlEvent(.editingChanged)
            .withLatestFrom(inputTextField.rx.text)
            .subscribe(onNext: { [weak self] value in
                self?.handle(value ?? "")
        }).disposed(by: _uiDisposeBag)
        
        self.button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
    }
    
    func setViewModel(_ vm: RequisitesCellViewModelProtocol) {
        self.vm = vm
        
        vm.text.subscribe(onNext: { [weak self] text in
            self?.inputTextField.text = text
        }).disposed(by: _viewModelBag)
        
        vm.errorText.subscribe(onNext: { [weak self] errorMessage in
            self?.errorLabel.text = errorMessage
        }).disposed(by: _viewModelBag)
        
        vm.isKeyboardEnabled.subscribe(onNext: { [weak self] enabled in
            if enabled {
                self?.inputTextField.becomeFirstResponder()
            } else {
                self?.inputTextField.resignFirstResponder()
            }
        })
        
        cellTitleLabel.text = vm.title
    }
    
    @objc func handleTap() {
        self.vm?.handleTapAction()
    }
    
    @objc func handle(_ text: String) {
        self.vm?.didChangeText(text)
    }
}

extension RequisiteCell: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.vm?.handleReturnTap()
        
        return true
    }
}
