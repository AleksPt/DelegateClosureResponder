//
//  RootView.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 07.10.2024.
//

import UIKit

final class RootView: UIView {
    
    var closure: (() -> ())?
    weak var rootDelegate: RootViewDelegate?
    
    // MARK: - UI
    let mainView = MainView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupView()
        setupConstraints()
        
        mainView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Public methods
    func changeColorWithClosure() {
        mainView.closure = closure
    }
    
    // MARK: - Private methods
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .systemGreen
    }
    
    private func addSubviews() {
        addSubview(mainView)
    }
}

// MARK: MainViewDelegate
extension RootView: MainViewDelegate {
    func changeColor() {
        rootDelegate?.changeColor()
    }
}

// MARK: - Setup constraints
private extension RootView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            topAnchor.constraint(equalTo: mainView.topAnchor, constant: -100),
            bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 100)
        ])
    }
}
