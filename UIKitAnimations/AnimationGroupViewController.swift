//
//  AnimationGroupViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/12/23.
//

import UIKit
import TheAnimation

final class AnimationGroupViewController: UIViewController {
    private let myLayer = CALayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(animateCube))

        myLayer.backgroundColor = UIColor.red.cgColor
        myLayer.cornerRadius = 12
        myLayer.frame = CGRect(x: view.bounds.midX - 60, y: 100, width: 120, height: 120)
        view.layer.addSublayer(myLayer)
    }

    @objc private func animateCube() {
        let animation = BasicAnimation(keyPath: .position)
        animation.fromValue = CGPoint(x: myLayer.frame.midX, y: myLayer.frame.midY)
        animation.toValue = CGPoint(x: view.bounds.midX, y: view.bounds.midY)

        let animation2 = BasicAnimation(keyPath: .opacity)
        animation2.fromValue = 1
        animation2.toValue = 0

        let animation3 = BasicAnimation(keyPath: .transformRotationZ)
        animation3.fromValue = 0
        animation3.toValue = .pi

        let animationGroup = AnimationGroup()
        animationGroup.animations = [animation, animation2, animation3]
        animationGroup.duration = 2
        animationGroup.beginTime = CACurrentMediaTime()
        animationGroup.timingFunction = .easeInEaseOut
        animationGroup.fillMode = .forwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.animate(in: myLayer)
    }
}
