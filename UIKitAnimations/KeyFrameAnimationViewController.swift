//
//  KeyFrameAnimationViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/11/23.
//

import UIKit
import SnapKit

class KeyFrameAnimationViewController: UIViewController {

    private let viewToAnimate = UIView()
    private lazy var button = UIButton(primaryAction: UIAction(title: "Animate", handler: buttonAction))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        viewToAnimate.layer.cornerRadius = 16
        viewToAnimate.backgroundColor = .red

        view.addSubview(viewToAnimate)
        viewToAnimate.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(100)
        }

        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
    }

    private func buttonAction(_ action: UIAction) {
        animateCube()
    }

    private func animateCube() {
        UIView.animateKeyframes(withDuration: 2, delay: 0) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) { [weak self] in
                self?.viewToAnimate.backgroundColor = UIColor.random
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) { [weak self] in
                self?.viewToAnimate.alpha = CGFloat.random(in: 0.5...1)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25) { [weak self] in
                self?.viewToAnimate.snp.updateConstraints({ make in
                    make.top.equalToSuperview().inset(Int.random(in: 100...200))
                })
                self?.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) { [weak self] in
                self?.viewToAnimate.snp.updateConstraints({ make in
                    make.width.equalTo(Int.random(in: 200...300))
                    make.height.equalTo(Int.random(in: 200...300))
                })
                self?.view.layoutIfNeeded()
            }
        }
    }
}
