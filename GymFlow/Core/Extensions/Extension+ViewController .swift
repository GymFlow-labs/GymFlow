//
//  UIViewController+Toast.swift
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
        let showOffset: CGFloat = 8
        let hideOffset: CGFloat = 120
        let animationDuration: TimeInterval = 0.25
        
        var host: UIHostingController<ToastView>!
        host = UIHostingController(
            rootView: ToastView(
                message: message,
                type: type,
                onClose: { [weak host] in
                    guard let host else { return }
                    UIView.animate(
                        withDuration: 0.2,
                        animations: {
                        host.view.alpha = 0
                    }, completion: { _ in
                        host.willMove(toParent: nil)
                        host.view.removeFromSuperview()
                        host.removeFromParent()
                    })
                }
            )
        )
        
        host.view.backgroundColor = UIColor.clear
        host.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(host)
        view.addSubview(host.view)
        host.didMove(toParent: self)
        
        let position = fromBottom
            ? host.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: hideOffset)
            : host.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -hideOffset)
        
        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            position
        ])
        
        view.layoutIfNeeded()
        position.constant = fromBottom ? -showOffset : showOffset
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self, weak host] in
            guard let self, let host else { return }
            position.constant = fromBottom ? hideOffset : -hideOffset
            UIView.animate(withDuration: animationDuration,
                           animations: {
                               self.view.layoutIfNeeded()
                           },
                           completion: { _ in
                               host.willMove(toParent: nil)
                               host.view.removeFromSuperview()
                               host.removeFromParent()
                           })
        }
    }
}
