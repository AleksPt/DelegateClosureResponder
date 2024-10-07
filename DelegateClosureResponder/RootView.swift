//
//  RootView.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 07.10.2024.
//

import UIKit

final class RootView: UIView {
    
    // MARK: - UI
    private let mainView = MainView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .systemGreen
    }
    
    // MARK: - Private methods
    private func addSubviews() {
        addSubview(mainView)
    }
}

private extension RootView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            mainView.centerYAnchor.constraint(equalTo: centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            topAnchor.constraint(equalTo: mainView.topAnchor, constant: -50),
            bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 50)
        ])
    }
}
