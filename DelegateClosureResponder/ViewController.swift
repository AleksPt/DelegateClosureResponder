//
//  ViewController.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 24.09.2024.
//

import UIKit

final class ViewController: UIViewController {
        
    var closure: (() -> ())?
    
    // MARK: - UI
    private let rootView = RootView()
    private lazy var resetButton: UIButton = {
        let button = UIButton(configuration: .borderedProminent())
        button.setTitle("Reset background color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.systemPink
        button.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupView()
        setupConstraints()
        
        changeBackgroundColorWithClosure()
    }
    
    // MARK: - Setup Views
    private func addSubviews() {
        [rootView, resetButton].forEach { view.addSubview($0) }
    }
    
    private func setupView() {
        view.backgroundColor = .white
    }
    
    // MARK: - Actions
    @objc private func didTapResetButton() {
        changeBackground(with: .white)
    }
    
    private func changeBackgroundColorWithClosure() {
        rootView.closure = { [weak self] in
            guard let self else { return }
            changeBackground(with: .systemGray)
        }
        rootView.changeColorWithClosure()
    }
    
    // MARK: - Private methods
    private func changeBackground(with color: UIColor) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = color
        }
    }
}

// MARK: - MainViewDelegate
extension ViewController: MainViewDelegate {
    func changeColor() {
        changeBackground(with: .systemBlue)
    }
}

// MARK: - Setup Constraints
private extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            rootView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            rootView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25)
        ])
    }
}
