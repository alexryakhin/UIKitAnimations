//
//  PullToRefreshViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/12/23.
//

import UIKit
import TheAnimation

class PullToRefreshViewController: UIViewController {

    private let activityIndicator = UIActivityIndicatorView()

    let shapeLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        activityIndicator.isHidden = true

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureAction))
        view.addGestureRecognizer(gestureRecognizer)
        view.layer.addSublayer(shapeLayer)

        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        shapeLayer.fillColor = UIColor.systemFill.cgColor
        shapeLayer.path = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))
    }

    @objc func gestureAction(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        struct AnimationSetting {
            static var isAnimation = false
            static var isLoading = false
        }

        switch sender.state {
        case .began:
            AnimationSetting.isAnimation = point.y < 200
            if AnimationSetting.isAnimation {
                shapeLayer.removeAllAnimations()
            }
        case .changed:
            guard AnimationSetting.isAnimation else { return }
            shapeLayer.path = createPath(point: point)
        case .ended, .failed, .cancelled:
            guard AnimationSetting.isAnimation else { return }
            animationStartingPosition(fromPoint: point) default: break }
    }

    func createPath(point: CGPoint) -> CGPath {
        let bezierPath = UIBezierPath()

        let startPoint = CGPoint(x: 0, y: 0)
        let endPoint = CGPoint(x: view.bounds.maxX, y: view.bounds.minY)
        bezierPath.move(to: startPoint)
        bezierPath.addCurve(to: endPoint, controlPoint1: point, controlPoint2: point)
        bezierPath.close()

        return bezierPath.cgPath
    }

    func animationStartingPosition(fromPoint: CGPoint) {
        let animation = CASpringAnimation(keyPath: "path")
        animation.fromValue = createPath(point: fromPoint)
        animation.toValue = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))

        animation.damping = 10
        animation.initialVelocity = 20.0
        animation.mass = 2.0
        animation.stiffness = 1000.0

        animation.duration = animation.settlingDuration

        animation.delegate = self
        shapeLayer.add(animation, forKey: nil)

        shapeLayer.path = createPath(point: CGPoint(x: view.bounds.maxX / 2, y: view.bounds.minY))
    }
}

//MARK: - CAAnimationDelegate

extension PullToRefreshViewController: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        shapeLayer.removeAllAnimations()

        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()

    }
}
