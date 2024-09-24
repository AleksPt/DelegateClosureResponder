//
//  ViewController.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 24.09.2024.
//

import UIKit

protocol ChangeColorProtocol: AnyObject {
    func changeColor(_ color: UIColor)
}

final class ViewController: UIViewController {
    
    weak var delegate: ChangeColorProtocol?
    lazy var closure = { [weak self] in
        self?.view.backgroundColor = .systemGray
    }
    
    // MARK: - UI
    private lazy var rootView = createCustomView(color: .systemGreen)
    private lazy var mainView = createCustomView(color: .systemYellow)
    
    private lazy var blueDelegateButton = createCustomButton(title: "Blue Delegate")
    private lazy var cyanResponderChainButton = createCustomButton(title: "Cyan Responder Chain")
    private lazy var grayClosureButton = createCustomButton(title: "Gray Closure")
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupViews()
        setupConstraints()
        
        delegate = self
    }
    
    // MARK: - Setup Views
    private func createCustomButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.layer.backgroundColor = UIColor.darkGray.cgColor
        button.layer.cornerRadius = 10
        button.setTitleColor(.yellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private func createCustomView(color: UIColor) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = color
        return view
    }
    
    private func addSubviews() {
        view.addSubview(rootView)
        rootView.addSubview(mainView)
        [
            blueDelegateButton,
            cyanResponderChainButton,
            grayClosureButton
        ].forEach { mainView.addSubview($0) }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        blueDelegateButton.addTarget(
            self,
            action: #selector(changeColorWithDelegate),
            for: .touchUpInside
        )
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
    }
    
    // MARK: - Actions
    @objc private func changeColorWithDelegate() {
        delegate?.changeColor(.systemBlue)
    }
    
    @objc private func changeColorWithClosure() {
        closure()
    }
    
    @objc private func changeColorWithResponderChain() {
        view.next?.changeColor()
    }
}

// MARK: - ChangeColorProtocol
extension ViewController: ChangeColorProtocol {
    func changeColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

// MARK: - UIResponder Extension
extension UIResponder {
    @objc func changeColor() {
        self.next?.changeColor()
    }
}

// MARK: - UIView Extension
extension UIViewController {
    override func changeColor() {
        self.view.backgroundColor = .systemCyan
    }
}

// MARK: - Setup Constraints
private extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            blueDelegateButton.heightAnchor.constraint(equalToConstant: 48),
            blueDelegateButton.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 8),
            blueDelegateButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -8),
            blueDelegateButton.bottomAnchor.constraint(equalTo: cyanResponderChainButton.topAnchor, constant: -8),
            
            cyanResponderChainButton.heightAnchor.constraint(equalTo: blueDelegateButton.heightAnchor),
            cyanResponderChainButton.widthAnchor.constraint(equalTo: blueDelegateButton.widthAnchor),
            cyanResponderChainButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            cyanResponderChainButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            
            grayClosureButton.heightAnchor.constraint(equalTo: blueDelegateButton.heightAnchor),
            grayClosureButton.widthAnchor.constraint(equalTo: blueDelegateButton.widthAnchor),
            grayClosureButton.topAnchor.constraint(equalTo: cyanResponderChainButton.bottomAnchor, constant: 8),
            grayClosureButton.centerXAnchor.constraint(equalTo: mainView.centerXAnchor),
            
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rootView.topAnchor.constraint(lessThanOrEqualTo: mainView.topAnchor, constant: -100),
            rootView.bottomAnchor.constraint(lessThanOrEqualTo: mainView.bottomAnchor, constant: 100),
            
            mainView.leadingAnchor.constraint(equalTo: rootView.leadingAnchor, constant: 16),
            mainView.trailingAnchor.constraint(equalTo: rootView.trailingAnchor, constant: -16),
            mainView.centerYAnchor.constraint(equalTo: rootView.centerYAnchor),
            mainView.centerXAnchor.constraint(equalTo: rootView.centerXAnchor),
            mainView.topAnchor.constraint(lessThanOrEqualTo: blueDelegateButton.topAnchor, constant: -100),
            mainView.bottomAnchor.constraint(lessThanOrEqualTo: grayClosureButton.bottomAnchor, constant: 100),
        ])
    }
}
