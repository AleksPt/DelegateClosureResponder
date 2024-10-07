//
//  Extensions.swift
//  DelegateClosureResponder
//
//  Created by Алексей on 07.10.2024.
//

import UIKit

extension UIResponder {
    @objc func changeColorResponder() {
        self.next?.changeColorResponder()
    }
}


extension UIViewController {
    override func changeColorResponder() {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = .systemCyan
        }
    }
}
