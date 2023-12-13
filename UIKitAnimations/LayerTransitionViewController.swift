//
//  LayerTransitionViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/13/23.
//

import UIKit

class LayerTransitionViewController: UIViewController {

    private let containerView = UIView()
    private var currentView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(buttonAction))

        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    @objc private func buttonAction() {
        performTransition()
    }

    private func performTransition() {
        // Create the new view with a different color
        let newView = createView(withColor: .random)

        // Set up a CATransition
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 0.5

        // Add the transition to the containerView's layer
        containerView.layer.add(transition, forKey: nil)

        // Remove the current view and add the new view
        currentView?.removeFromSuperview()
        containerView.addSubview(newView)
        currentView = newView
    }

    private func createView(withColor color: UIColor) -> UIView {
        let view = UIView(frame: containerView.bounds)
        view.backgroundColor = color
        view.layer.cornerRadius = 16
        return view
    }
}
