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
    
    private var vm: RequisitesCellViewModelProtocol?
    private var _disposeBag = DisposeBag()
    
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
        
        _disposeBag = DisposeBag()
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
        
        self.inputTextField.rx.controlEvent(.editingChanged)
            .withLatestFrom(inputTextField.rx.text)
            .subscribe(onNext: { [weak self] value in
                self?.handle(value ?? "")
        }).disposed(by: _disposeBag)
    }
    
    func setViewModel(_ vm: RequisitesCellViewModelProtocol) {
        self.vm = vm
        
        vm.text.subscribe(onNext: { [weak self] text in
            self?.inputTextField.text = text
        }).disposed(by: _disposeBag)
        
        vm.errorText.subscribe(onNext: { [weak self] errorMessage in
            self?.errorLabel.text = errorMessage
        }).disposed(by: _disposeBag)
        
        cellTitleLabel.text = vm.title
    }
    
    @objc func handle(_ text: String) {
        self.vm?.didChangeText(text)
    }
}
