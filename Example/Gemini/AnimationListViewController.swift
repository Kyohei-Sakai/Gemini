//
//  AnimationListViewController.swift
//  Gemini
//
//  Created by shoheiyokoyama on 2017/06/19.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

final class AnimationListViewController: UIViewController {

    fileprivate let cellIdentifier = "tableViewCell"
    fileprivate let sectionTitles = ["Cube", "CircleRotate", "RollRotation", "PitchRotation"]
    fileprivate let cellTitles: [[String]] = [
        ["Horizontal cube",
         "Vertical cube"],
        ["Horizontal clockwise rotation",
         "Horizontal anticlockwise rotation",
         "Vertical clockwise rotation",
         "Vertical anticlockwise rotation"],
        ["Horizontal roll up",
         "Horizontal roll down",
         "Horizontal sine wave",
         "Horizontal reverse sine wave",
         "Vertical roll up",
         "Vertical roll down",
         "Vertical sine wave",
         "Vertical reverse sine wave"],
        ["Horizontal pictch up",
         "Horizontal pictch down",
         "Horizontal sine wave",
         "Horizontal reverse sine wave",
         "Vertical pictch up",
         "Vertical pictch down",
         "Vertical sine wave",
         "Vertical reverse sine wave"]
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
            let viewController = CircleRotationViewController.make(with: .horizontal, rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 1):
            let viewController = CircleRotationViewController.make(with: .horizontal, rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 2):
            let viewController = CircleRotationViewController.make(with: .vertical, rotateDirection: .clockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (1, 3):
            let viewController = CircleRotationViewController.make(with: .vertical, rotateDirection: .anticlockwise)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 0):
            let viewController = RollRotationViewController.make(with: .horizontal, effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 1):
            let viewController = RollRotationViewController.make(with: .horizontal, effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 2):
            let viewController = RollRotationViewController.make(with: .horizontal, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 3):
            let viewController = RollRotationViewController.make(with: .horizontal, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 4):
            let viewController = RollRotationViewController.make(with: .vertical, effect: .rollUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 5):
            let viewController = RollRotationViewController.make(with: .vertical, effect: .rollDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 6):
            let viewController = RollRotationViewController.make(with: .vertical, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (2, 7):
            let viewController = RollRotationViewController.make(with: .vertical, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 0):
            let viewController = PitchRotationViewController.make(with: .horizontal, effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 1):
            let viewController = PitchRotationViewController.make(with: .horizontal, effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 2):
            let viewController = PitchRotationViewController.make(with: .horizontal, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 3):
            let viewController = PitchRotationViewController.make(with: .horizontal, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 4):
            let viewController = PitchRotationViewController.make(with: .vertical, effect: .pitchUp)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 5):
            let viewController = PitchRotationViewController.make(with: .vertical, effect: .pitchDown)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 6):
            let viewController = PitchRotationViewController.make(with: .vertical, effect: .sineWave)
            navigationController?.pushViewController(viewController, animated: true)
        case (3, 7):
            let viewController = PitchRotationViewController.make(with: .vertical, effect: .reverseSineWave)
            navigationController?.pushViewController(viewController, animated: true)

        default:
            ()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        return 60
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
