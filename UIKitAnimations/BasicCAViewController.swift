//
//  BasicCAViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/12/23.
//

import UIKit
import TheAnimation

final class BasicCAViewController: UIViewController {
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
        animatePosition()
        animateOpacity()
        animateRotation()
    }

    private func animatePosition() {
        // Custom timing function
        let controlPoint1 = CGPoint(x: 0.25, y: 0.1)
        let controlPoint2 = CGPoint(x: 0.25, y: 1.0)
        let timingFunction = TimingFunction(
            controlPoints: Float(controlPoint1.x),
            Float(controlPoint1.y),
            Float(controlPoint2.x),
            Float(controlPoint2.y)
        )

        let animation = BasicAnimation(keyPath: .position)
        animation.fromValue = CGPoint(x: myLayer.frame.midX, y: myLayer.frame.midY)
        animation.toValue = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
//        animation.timingFunction = timingFunction
        animation.timingFunction = .easeInEaseOut
        animation.animate(in: myLayer)
    }

    private func animateOpacity() {
        let animation = BasicAnimation(keyPath: .opacity)
        animation.fromValue = 1
        animation.toValue = 0
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        animation.animate(in: myLayer)
    }

    private func animateRotation() {
        let animation = BasicAnimation(keyPath: .transformRotationZ)
        animation.fromValue = 0
        animation.toValue = .pi
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.beginTime = CACurrentMediaTime()
        animation.animate(in: myLayer)
    }
}
