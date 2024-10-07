//
//  MainView.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 07.10.2024.
//

import UIKit

final class MainView: UIView {
    
    weak var delegate: MainViewDelegate?
    var closure: (()->())?
    
    // MARK: - UI
    private lazy var blueDelegateButton = createCustomButton(title: "Blue Delegate")
    private lazy var cyanResponderChainButton = createCustomButton(title: "Cyan Responder Chain")
    private lazy var grayClosureButton = createCustomButton(title: "Gray Closure")
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupView()
        setupButton()
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
    
    private func setupButton() {
        cyanResponderChainButton.addTarget(
            self,
            action: #selector(changeColorWithResponderChain),
            for: .touchUpInside
        )
        
        grayClosureButton.addTarget(
            self,
            action: #selector(changeColorWithClosure),
            for: .touchUpInside
        )
        
        blueDelegateButton.addTarget(
            self,
            action: #selector(changeColorWithDelegate),
            for: .touchUpInside
        )
    }
    
    private func addSubviews() {
        [
            blueDelegateButton,
            cyanResponderChainButton,
            grayClosureButton
        ].forEach { addSubview($0) }
    }
    
    // MARK: - Actions
    @objc private func changeColorWithDelegate() {
        delegate?.changeColor()
    }
    
    @objc private func changeColorWithClosure() {
        closure?()
    }
    
    @objc private func changeColorWithResponderChain() {
        UIApplication.shared.sendAction(#selector(ViewController.changeColorResponder), to: nil, from: self, for: nil)
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
            
            heightAnchor.constraint(equalToConstant: 350)
        ])
    }
}
