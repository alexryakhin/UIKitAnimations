//
//  EmitterViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/13/23.
//

import UIKit

final class EmitterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Let it snow",
            style: .plain,
            target: self,
            action: #selector(letItSnow)
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.overrideUserInterfaceStyle = .unspecified
    }

    private func setBackground() {
        let imageView = UIImageView(image: UIImage(resource: .winterBackground))
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
        imageView.clipsToBounds = true
        view.layer.insertSublayer(imageView.layer, at: 0)
    }

    @objc private func letItSnow() {
        let emitterLayer = emitter()
        emitterLayer.position = CGPoint(x: view.frame.width / 2, y: 0)
        emitterLayer.emitterSize = CGSize(width: view.frame.width, height: 1)
        guard let layers = view.layer.sublayers,
                !layers.contains(where: { $0 is CAEmitterLayer })
        else { return }
        view.layer.addSublayer(emitterLayer)
    }

    private func emitter() -> CAEmitterLayer {
        let layer = CAEmitterLayer()
        layer.emitterShape = .line
        layer.emitterCells = emitterCells()
        return layer
    }

    private func emitterCells() -> [CAEmitterCell] {
        let images = [
            UIImage(resource: .snowflake1),
            UIImage(resource: .snowflake2),
            UIImage(resource: .snowflake3),
            UIImage(resource: .snowflake4)
        ]
        return images.map { image in
            emitterCell(with: image)
        }
    }

    private func emitterCell(with image: UIImage) -> CAEmitterCell {
        let cell = CAEmitterCell()

        cell.contents = image.cgImage
        cell.birthRate = 0.6
        cell.lifetime = 40
        cell.velocity = 40
        cell.emissionLongitude = (180 * (.pi/180))
        cell.emissionRange = (45 * (.pi/180))
        cell.scale = 0.3
        cell.scaleRange = 0.1

        return cell
    }
}
