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
    let textField = UITextField()
    let errorLabel = UILabel()
    let titleLabel = UILabel()
    
    private var vm: RequisitesCellViewModelProtocol?
    private let _disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.textField.rx.controlEvent(.editingChanged)
            .withLatestFrom(textField.rx.text)
            .subscribe(onNext: { [weak self] value in
                self?.vm?.didChangeText(value ?? "")
        }).disposed(by: _disposeBag)
        
        self.textField.addTarget(self, action: #selector(handle(_:)), for: .editingChanged)
    }
    
    func setViewModel(_ vm: RequisitesCellViewModelProtocol) {
        self.vm = vm
        
        vm.text.subscribe(onNext: { [weak self] text in
            self?.textField.text = text
        }).disposed(by: _disposeBag)
        
        vm.errorText.subscribe(onNext: { [weak self] errorMessage in
            self?.errorLabel.text = errorMessage
        }).disposed(by: _disposeBag)
        
        titleLabel.text = vm.title
    }
    
    @objc func handle(_ text: String) {
        self.vm?.didChangeText(text)
    }
}
