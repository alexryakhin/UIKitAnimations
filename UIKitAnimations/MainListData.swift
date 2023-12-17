//
//  MainListItem.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/17/23.
//

import UIKit

enum MainListSection: Hashable {
    case main
}

enum MainListItem: Hashable, CaseIterable {
    case standardAnimation
    case keyFrameAnimation
    case transition
    case layerTransition
    case basicCA
    case animationGroup
    case shapeAnimation
    case shapeStrokeAnimation
    case pullToRefresh
    case transformLayer
    case emitter
    case replication
    case affineTransform

    var title: String {
        switch self {
        case .standardAnimation: "Standard Animation"
        case .keyFrameAnimation: "Key Frame Animation"
        case .transition: "Transition"
        case .layerTransition: "Layer transition"
        case .basicCA: "Basic Core Animation"
        case .animationGroup: "Animation group"
        case .shapeAnimation: "Shape Animation"
        case .shapeStrokeAnimation: "Shape Stroke Animation"
        case .pullToRefresh: "Pull to refresh"
        case .transformLayer: "Transform"
        case .emitter: "Emitter (Winder theme)"
        case .replication: "Replication"
        case .affineTransform: "AffineTransform"
        }
    }

    var viewController: UIViewController {
        switch self {
        case .standardAnimation: return StandardAnimationViewController()
        case .keyFrameAnimation: return KeyFrameAnimationViewController()
        case .transition: return TransitionViewController()
        case .layerTransition: return LayerTransitionViewController()
        case .basicCA: return BasicCAViewController()
        case .animationGroup: return AnimationGroupViewController()
        case .shapeAnimation: return ShapeAnimationViewController()
        case .shapeStrokeAnimation: return ShapeStrokeAnimationViewController()
        case .pullToRefresh: return PullToRefreshViewController()
        case .transformLayer: return TransformLayerViewController()
        case .emitter: return EmitterViewController()
        case .replication: return ReplicationViewController()
        case .affineTransform: return AffineTransformViewController()
        }
    }
}
