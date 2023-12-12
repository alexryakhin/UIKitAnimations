//
//  MainListViewController.swift
//  UIKitAnimations
//
//  Created by Aleksandr Riakhin on 12/11/23.
//

import UIKit

enum MainListSection: Hashable {
    case main
}

enum MainListItem: Hashable, CaseIterable {
    case standardAnimation
    case keyFrameAnimation
    case transition
    case basicCA
    case animationGroup
    case shapeAnimation
    case pullToRefresh

    var title: String {
        switch self {
        case .standardAnimation:
            "Standard Animation"
        case .keyFrameAnimation:
            "Key Frame Animation"
        case .transition:
            "Transition"
        case .basicCA:
            "Basic Core Animation"
        case .animationGroup:
            "Animation group"
        case .shapeAnimation:
            "Shape Animation"
        case .pullToRefresh:
            "Pull to refresh"
        }
    }
}

final class MainListViewController: UIViewController {
    typealias DataSource = UITableViewDiffableDataSource<MainListSection, MainListItem>

    private let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

    private var dataSource: DataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSubviews()
    }

    private func addSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        title = "Animations Bootcamp"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        dataSource = tableViewDataSource()
        tableView.dataSource = dataSource
        tableView.delegate = self
        applyInitialSnapshot()
    }

    private func tableViewDataSource() -> DataSource {
        return DataSource(tableView: tableView) { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            var content = cell.defaultContentConfiguration()
            content.text = model.title
            cell.contentConfiguration = content
            return cell
        }
    }

    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<MainListSection, MainListItem>()

        snapshot.appendSections([.main])
        snapshot.appendItems(MainListItem.allCases, toSection: .main)

        dataSource?.apply(snapshot)
    }
}

extension MainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = MainListItem.allCases[indexPath.row]
        let viewController: UIViewController
        switch item {
        case .standardAnimation:
            viewController = StandardAnimationViewController()
        case .keyFrameAnimation:
            viewController = KeyFrameAnimationViewController()
        case .transition:
            viewController = TransitionViewController()
        case .basicCA:
            viewController = BasicCAViewController()
        case .animationGroup:
            viewController = AnimationGroupViewController()
        case .shapeAnimation:
            viewController = ShapeAnimationViewController()
        case .pullToRefresh:
            viewController = PullToRefreshViewController()
        }
        viewController.title = item.title
        navigationController?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
