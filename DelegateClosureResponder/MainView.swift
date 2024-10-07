//
//  MainView.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 07.10.2024.
//

import UIKit

final class MainView: UIView {
    
    // MARK: - UI
    private lazy var blueDelegateButton = createCustomButton(title: "Blue Delegate")
    private lazy var cyanResponderChainButton = createCustomButton(title: "Cyan Responder Chain")
    private lazy var grayClosureButton = createCustomButton(title: "Gray Closure")
    
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
    
    // MARK: - Private methods
    private func createCustomButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.backgroundColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(.yellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = .systemYellow
    }
    
    private func addSubviews() {
        [
            blueDelegateButton,
            cyanResponderChainButton,
            grayClosureButton
        ].forEach { addSubview($0) }
    }
}

private extension MainView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            blueDelegateButton.heightAnchor.constraint(equalToConstant: 48),
            blueDelegateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            blueDelegateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            blueDelegateButton.bottomAnchor.constraint(equalTo: cyanResponderChainButton.topAnchor, constant: -8),
            
            cyanResponderChainButton.heightAnchor.constraint(equalTo: blueDelegateButton.heightAnchor),
            cyanResponderChainButton.widthAnchor.constraint(equalTo: blueDelegateButton.widthAnchor),
            cyanResponderChainButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            cyanResponderChainButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            grayClosureButton.heightAnchor.constraint(equalTo: blueDelegateButton.heightAnchor),
            grayClosureButton.widthAnchor.constraint(equalTo: blueDelegateButton.widthAnchor),
            grayClosureButton.topAnchor.constraint(equalTo: cyanResponderChainButton.bottomAnchor, constant: 8),
            grayClosureButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
