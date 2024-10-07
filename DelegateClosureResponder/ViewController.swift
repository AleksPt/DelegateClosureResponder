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
    private let rootView = RootView()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
        setupConstraints()
        
        delegate = self
    }
    
    // MARK: - Setup Views
    private func addSubviews() {
        view.addSubview(rootView)
    }
    
    private func setupView() {
        view.backgroundColor = .white
//        blueDelegateButton.addTarget(
//            self,
//            action: #selector(changeColorWithDelegate),
//            for: .touchUpInside
//        )
//        cyanResponderChainButton.addTarget(
//            self,
//            action: #selector(changeColorWithResponderChain),
//            for: .touchUpInside
//        )
//        grayClosureButton.addTarget(
//            self,
//            action: #selector(changeColorWithClosure),
//            for: .touchUpInside
//        )
    }
    
    // MARK: - Actions
//    @objc private func changeColorWithDelegate() {
//        delegate?.changeColor(.systemBlue)
//    }
//    
//    @objc private func changeColorWithClosure() {
//        closure()
//    }
//    
//    @objc private func changeColorWithResponderChain() {
//        view.next?.changeColor()
//    }
}

// MARK: - ChangeColorProtocol
extension ViewController: ChangeColorProtocol {
    func changeColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}

//// MARK: - UIResponder Extension
//extension UIResponder {
//    @objc func changeColor() {
//        self.next?.changeColor()
//    }
//}
//
//// MARK: - UIView Extension
//extension UIViewController {
//    override func changeColor() {
//        self.view.backgroundColor = .systemCyan
//    }
//}

// MARK: - Setup Constraints
private extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
