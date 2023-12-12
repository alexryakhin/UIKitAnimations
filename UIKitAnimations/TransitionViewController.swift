//
//  TransitionViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/11/23.
//

import UIKit

final class TransitionViewController: UIViewController {
    private lazy var regularButton = UIButton(primaryAction: UIAction(title: "Button 1", handler: buttonAction))
    private lazy var regularButton2 = UIButton(primaryAction: UIAction(title: "Button 2", handler: buttonAction2))

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground

        view.addSubview(regularButton)
        regularButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview().offset(-100)
        }

        var regularButtonConfig = UIButton.Configuration.filled()
        regularButtonConfig.baseBackgroundColor = UIColor.systemPink
        regularButton.configuration = regularButtonConfig

        var regularButtonConfig2 = UIButton.Configuration.filled()
        regularButtonConfig2.baseBackgroundColor = UIColor.blue
        regularButton2.configuration = regularButtonConfig2
    }

    private func buttonAction(_ action: UIAction) {
        if !view.subviews.contains(regularButton2) {
            view.addSubview(regularButton2)
        }
        regularButton2.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview().offset(100)
        }
        view.layoutIfNeeded()
        UIView.transition(from: regularButton, to: regularButton2, duration: 0.5, options: [.transitionCrossDissolve])
    }

    private func buttonAction2(_ action: UIAction) {
        if !view.subviews.contains(regularButton) {
            view.addSubview(regularButton)
        }
        regularButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.centerX.equalToSuperview().offset(-100)
        }
        view.layoutIfNeeded()
        UIView.transition(from: regularButton2, to: regularButton, duration: 0.5, options: [.transitionCrossDissolve])
    }
}
