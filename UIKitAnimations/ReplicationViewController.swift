//
//  ReplicationViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/17/23.
//

import UIKit

final class ReplicationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupReplicationLayer(image: UIImage.snowflake2)
    }

    private func setupReplicationLayer(image: UIImage) {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = view.frame.size
        replicatorLayer.masksToBounds = true
        view.layer.addSublayer(replicatorLayer)

        let imageLayer = CALayer()
        imageLayer.contents = image.cgImage
        imageLayer.frame.size = image.size
        replicatorLayer.addSublayer(imageLayer)

        let instanceCount = view.frame.width / image.size.width
        replicatorLayer.instanceCount = Int(ceil(instanceCount))

        // Shift each instance by the width of the image
        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            image.size.width, 0, 0
        )

        // Reduce the red & green color component of each instance,
        // effectively making each copy more and more blue
        let colorOffset = -1 / Float(replicatorLayer.instanceCount)
        replicatorLayer.instanceRedOffset = colorOffset
        replicatorLayer.instanceGreenOffset = colorOffset

        // MARK: - here we're replicating the first horizontal layer down vertically

        let verticalReplicatorLayer = CAReplicatorLayer()
        verticalReplicatorLayer.frame.size = view.frame.size
        verticalReplicatorLayer.masksToBounds = true
        verticalReplicatorLayer.instanceBlueOffset = colorOffset
        view.layer.addSublayer(verticalReplicatorLayer)

        let verticalInstanceCount = view.frame.height / image.size.height
        verticalReplicatorLayer.instanceCount = Int(ceil(verticalInstanceCount))

        verticalReplicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            0, image.size.height, 0
        )

        verticalReplicatorLayer.addSublayer(replicatorLayer)

        // MARK: - animation

        let delay = TimeInterval(0.1)
        replicatorLayer.instanceDelay = delay
        verticalReplicatorLayer.instanceDelay = delay

        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 2
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.autoreverses = true
        animation.repeatCount = .infinity
        imageLayer.add(animation, forKey: "hypnoscale")
    }
}
