//
//  AffineTransformViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/17/23.
//

import UIKit

final class AffineTransformViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Animate", style: .plain, target: self, action: #selector(buttonAction))
        view.backgroundColor = .systemBackground
    }

    @objc private func buttonAction() {

    }
}
