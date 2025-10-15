//
//  Extension+ViewController .swift
//  GymFlow
//
//  Created by Artem Kriukov on 15.10.2025.
//

import SwiftUI
import UIKit

extension UIViewController {
    func showSwiftUIToast(
        message: String,
        type: ToastType = .success,
        fromBottom: Bool = true,
        duration: TimeInterval = 2.0
    ) {
        let host = UIHostingController(rootView: ToastView(message: message, type: type) { })
        host.view.backgroundColor = .clear
        addChild(host)
        view.addSubview(host.view)
        host.didMove(toParent: self)

        host.view.translatesAutoresizingMaskIntoConstraints = false
        let edge = fromBottom
        ? host.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 120)
        : host.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -120)

        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            edge
        ])
        view.layoutIfNeeded()

        edge.constant = fromBottom ? -8 : 8
        UIView.animate(withDuration: 0.25) { self.view.layoutIfNeeded() }

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            edge.constant = fromBottom ? 120 : -120
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
            }) { _ in
                host.willMove(toParent: nil)
                host.view.removeFromSuperview()
                host.removeFromParent()
            }
        }
    }
}
