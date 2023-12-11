//
//  ViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/10/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    private let viewToAnimate = UIView()
    private lazy var button = UIButton(primaryAction: UIAction(title: "Animate", handler: buttonAction))

    private var randomColor: UIColor {
        switch Int.random(in: 0..<5) {
        case 0: return UIColor.green
        case 1: return UIColor.blue
        case 2: return UIColor.yellow
        case 3: return UIColor.magenta
        case 4: return UIColor.cyan
        default: return UIColor.red
        }
    }

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
        animateCube1()
    }

    private func animateCube1() {
        UIView.animate(
            withDuration: 1,
            delay: 0.3,
            options: [.transitionCurlUp]
        ) { [weak self] in
            self?.viewToAnimate.backgroundColor = self?.randomColor
            self?.viewToAnimate.snp.updateConstraints({ make in
                make.width.equalTo(Int.random(in: 200...300))
                make.height.equalTo(Int.random(in: 200...300))
            })
            self?.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                options: [.transitionCurlUp]
            ) {
                self?.viewToAnimate.snp.updateConstraints({ make in
                    make.top.equalToSuperview().inset(Int.random(in: 100...200))
                })
                self?.viewToAnimate.layer.cornerRadius = CGFloat.random(in: 8...32)
                self?.view.layoutIfNeeded()
            }
        }
    }

    private func animateCube2() {
        UIView.animate(
            withDuration: 1,
            delay: 0.3,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.4
        ) { [weak self] in
            self?.viewToAnimate.backgroundColor = self?.randomColor
            self?.viewToAnimate.snp.updateConstraints({ make in
                make.width.equalTo(Int.random(in: 200...300))
                make.height.equalTo(Int.random(in: 200...300))
            })
            self?.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            UIView.animate(withDuration: 0.4) {
                self?.viewToAnimate.snp.updateConstraints({ make in
                    make.top.equalToSuperview().inset(Int.random(in: 100...200))
                })
                self?.viewToAnimate.layer.cornerRadius = CGFloat.random(in: 8...32)
                self?.view.layoutIfNeeded()
            }
        }
    }

    private func animateCube3() {
        UIView.animateKeyframes(withDuration: 2, delay: 0) { [weak self] in
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) { [weak self] in
                self?.viewToAnimate.backgroundColor = self?.randomColor
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
