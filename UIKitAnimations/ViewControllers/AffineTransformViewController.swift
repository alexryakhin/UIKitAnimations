//
//  AffineTransformViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/17/23.
//

import UIKit
import SnapKit

final class AffineTransformViewController: UIViewController {

    private let viewToTransform = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuButton()
        view.backgroundColor = .systemBackground
        viewToTransform.layer.cornerRadius = 16
        viewToTransform.backgroundColor = .red

        view.addSubview(viewToTransform)
        viewToTransform.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.center.equalToSuperview()
        }
    }

    private func setupMenuButton() {
        let menuChildren = [
            UIAction(title: "Scale") { [weak self] _ in
                self?.scaleTransform()
            },
            UIAction(title: "Rotate") { [weak self] _ in
                self?.rotateTransform()
            },
            UIAction(title: "Scale and rotate") { [weak self] _ in
                self?.scaleAndRotateTransform()
            },
            UIAction(title: "Translate") { [weak self] _ in
                self?.translateTransform()
            },
            UIAction(title: "Identity") { [weak self] _ in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.viewToTransform.transform = .identity
                }
            },
        ]
        let menu = UIMenu(children: menuChildren)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", menu: menu)
    }

    private func scaleTransform() {
        let scaleTransform = CGAffineTransform(scaleX: 2, y: 2)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewToTransform.transform = scaleTransform
        }
    }

    private func rotateTransform() {
        let rotateTransform = CGAffineTransform(rotationAngle: .pi / 2)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewToTransform.transform = rotateTransform
        }
    }

    private func scaleAndRotateTransform() {
        let scaleTransform = CGAffineTransform(scaleX: 2, y: 2)
        let rotateTransform = CGAffineTransform(rotationAngle: .pi / 2)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewToTransform.transform = scaleTransform.concatenating(rotateTransform)
        }
    }

    private func translateTransform() {
        let translateTransform = CGAffineTransform(translationX: 200, y: 200)
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.viewToTransform.transform = translateTransform
        }
    }
}
