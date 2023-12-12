//
//  StandardAnimationViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/10/23.
//

import UIKit
import SnapKit

class StandardAnimationViewController: UIViewController {

    private let viewToAnimate = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(buttonAction))
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
    }

    @objc private func buttonAction() {
        animateCube2()
    }

    private func animateCube1() {
        UIView.animate(
            withDuration: 1,
            delay: 0.3,
            options: [.transitionCurlUp]
        ) { [weak self] in
            self?.viewToAnimate.backgroundColor = UIColor.random
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
            self?.viewToAnimate.backgroundColor = UIColor.random
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
}
