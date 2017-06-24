//
//  AnimationListViewController.swift
//  Gemini
//
//  Created by Shohei Yokoyama on 2017/06/19.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

final class AnimationListViewController: UIViewController {

    fileprivate let cellIdentifier = "tableViewCell"
    fileprivate let sectionTitles = ["cube", "circleRotate", "rollRotation"]
    fileprivate let cellTitles: [[String]] = [
        ["【scroll】horizontal",
         "【scroll】vertical"],
        ["【scroll】.horizontal 【rotate】.default",
         "【scroll】.horizontal 【rotate】.reverse",
         "【scroll】.vertical 【rotate】.default",
         "【scroll】.vertical 【rotate】.reverse"],
        ["RollRotation"]
    ]

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate   = self
            tableView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - UITableViewDelegate
extension AnimationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.section, indexPath.row) {
        case (0, _):
            let direction: UICollectionViewScrollDirection = indexPath.row == 0 ? .horizontal : .vertical
            let viewController = CubeViewController.make(with: direction)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 0):
            let viewController = CircleRotateViewController.make(with: .horizontal, rotateDirection: .default)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 1):
            let viewController = CircleRotateViewController.make(with: .horizontal, rotateDirection: .reverse)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 2):
            let viewController = CircleRotateViewController.make(with: .vertical, rotateDirection: .default)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 3):
            let viewController = CircleRotateViewController.make(with: .vertical, rotateDirection: .reverse)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, _):
            let viewController = RollRotationViewController.make()
            navigationController?.pushViewController(viewController, animated: true)
        default:
            ()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 15, y: 20), size: .zero))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        titleLabel.text = sectionTitles[section]
        titleLabel.sizeToFit()
        headerView.addSubview(titleLabel)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - UITableViewDataSource
extension AnimationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell.selectionStyle = .none
        cell.textLabel?.text = cellTitles[indexPath.section][indexPath.row]
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles[section].count
    }
}
