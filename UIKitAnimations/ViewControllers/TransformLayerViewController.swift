//
//  TransformLayerViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/13/23.
//  https://www.hackingwithswift.com/articles/135/how-to-render-uiviews-in-3d-using-catransformlayer

import UIKit
import TheAnimation

final class TransformLayerViewController: UIViewController {

    private let imageView = UIImageView(frame: CGRect(x: -150, y: -150, width: 300, height: 300))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        imageView.image = UIImage(named: "cat")
        imageView.contentMode = .scaleAspectFit
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Animate",
            style: .plain,
            target: self,
            action: #selector(buttonAction)
        )
        setupTransformLayer()
    }

    func setupTransformLayer() {
        /*
         That creates a 3D transform, modifies it slightly, then applies it to a transform layer. The curious part is the second line, which modifies a property called m34 to be -1 / 500. CATransform3D is 4x4 matrix of numbers, so it has properties such as m11, m12, m21, and so on up to m44. Each one refers to the value in a specific row and column of the transformation matrix.

         Taken together, a CATransform3D defines exactly how an object is positioned in space – its position, rotation, and so on. We don’t need anything fancy for our transform layer, but we do want it to simulate some perspective. That’s where m34 comes in: it’s sort of like the distance from your eye to where the scene is being rendered, and it effects how strong the 3D effects appeared. Later on you can try adjusting it to see what I mean – a value like -1 / 100 will have a really strong 3D effect, whereas -1 / 2000 will be much weaker.
         */
        let transformLayer = CATransformLayer()
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 500
        transformLayer.transform = perspective

        transformLayer.position = CGPoint(x: view.bounds.midX, y: view.bounds.midY)

        transformLayer.addSublayer(imageView.layer)
        view.layer.addSublayer(transformLayer)
    }

    @objc private func buttonAction() {
        animateImage()
    }

    private func animateImage() {
        let animation = BasicAnimation(keyPath: .transform)
        animation.fromValue = CATransform3DMakeRotation(0.5, 1, 0, 0)
        animation.toValue = CATransform3DMakeRotation(-0.5, 1, 0, 0)
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = 10
        animation.animate(in: imageView.layer)
    }
}
