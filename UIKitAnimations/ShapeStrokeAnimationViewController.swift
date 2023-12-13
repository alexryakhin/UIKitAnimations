//
//  ShapeStrokeAnimationViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/13/23.
//

import UIKit

final class ShapeStrokeAnimationViewController: UIViewController {

    private let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Animate",
            style: .plain,
            target: self,
            action: #selector(buttonAction)
        )
        setup()
    }

    private func setup() {
        let circlePath = UIBezierPath(
            arcCenter: view.center,
            radius: 100,
            startAngle: -.pi / 2,
            endAngle: 3 * .pi / 2,
            clockwise: true
        )

        // Gray circle beneath the main circle
        let grayCircle = CAShapeLayer()
        grayCircle.path = circlePath.cgPath
        grayCircle.strokeColor = UIColor.systemFill.cgColor
        grayCircle.lineWidth = 10
        grayCircle.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(grayCircle)

        // Main circle
        shapeLayer.path = circlePath.cgPath
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round

        view.layer.addSublayer(shapeLayer)
    }

    @objc private func buttonAction() {
        animateStroke()
    }

    private func animateStroke() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")

        animation.toValue = 1
        animation.duration = 2
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        shapeLayer.add(animation, forKey: nil)
    }
}

