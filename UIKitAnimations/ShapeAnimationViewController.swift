//
//  ShapeAnimationViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/12/23.
//

import UIKit
import SnapKit
import TheAnimation

final class ShapeAnimationViewController: UIViewController {
    private let arrowView = ArrowView()
    private var reverseAnimation = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(buttonAction))
        view.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(200)
        }
    }

    @objc private func buttonAction() {
        reverseAnimation.toggle()
        let (leadingPercentage, trailingPercentage) = reverseAnimation ? (20, 20) : (30, 30)

        arrowView.setup(
            leadingPercentage: leadingPercentage,
            trailingPercentage: trailingPercentage,
            animate: true
        )
    }
}

class ArrowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialConfig()
    }

    let shapeLayer = CAShapeLayer()

    private var fillColor: UIColor = .blue

    /// width percentage of space between view leading and edge leading
    ///
    /// The value should be between 0 and 100
    private var leadingEdgeWidthPercentage = 20

    /// width percentage of space between view trailing and edge trailing
    ///
    /// The value should be between 0 and 100
    private var trailingEdgeWidthPercentage = 20

    private func initialConfig() {
        backgroundColor = .clear
        layer.addSublayer(shapeLayer)
        setup()
    }

    func setup(
        fillColor: UIColor? = nil,
        leadingPercentage: Int? = nil,
        trailingPercentage: Int? = nil,
        animate: Bool = false
    ) {

        if let fillColor {
            self.fillColor = fillColor
        }

        if let leading = leadingPercentage, isValidPercentageRange(leading) {
            self.leadingEdgeWidthPercentage = leading
        }

        if let trailing = trailingPercentage, isValidPercentageRange(trailing) {
            self.trailingEdgeWidthPercentage = trailing
        }

        if animate {
            animateShape()
        } else {
            changeShape()
        }
    }

    private func changeShape() {
        shapeLayer.path = arrowShapePath().cgPath
        shapeLayer.fillColor = fillColor.cgColor
    }

    private func isValidPercentageRange(_ percentage: Int) -> Bool {
        return 0 ... 100 ~= percentage
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        shapeLayer.removeAllAnimations()
        changeShape()
    }

    private func animateShape() {
        let newShapePath = arrowShapePath().cgPath

        let animation = BasicAnimation(keyPath: .path)
        animation.duration = 2
        animation.toValue = newShapePath
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = .easeOut
        animation.animation.delegate = self
        animation.animate(in: shapeLayer)
    }

    private func arrowShapePath() -> UIBezierPath {
        let size = bounds.size
        let leadingEdgeWidth = size.width * CGFloat(leadingEdgeWidthPercentage) / 100
        let trailingEdgeWidth = size.width * (1 - CGFloat(trailingEdgeWidthPercentage) / 100)

        let path = UIBezierPath()

        // move to zero point (top-right corner)
        path.move(to: CGPoint(x: 0, y: 0))

        // move to right inner edge point
        path.addLine(to: CGPoint(x: leadingEdgeWidth, y: size.height/2))

        // move to bottom-left corner
        path.addLine(to: CGPoint(x: 0, y: size.height))

        // move to bottom-right side
        path.addLine(to: CGPoint(x: trailingEdgeWidth, y: size.height))

        // move to left outer edge point
        path.addLine(to: CGPoint(x: size.width, y: size.height/2))

        // move to top-right side
        path.addLine(to: CGPoint(x: trailingEdgeWidth, y: 0))

        // close the path. This will create the last line automatically.
        path.close()

        return path
    }
}

extension ArrowView: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag { changeShape() }
    }
}
