//
//  MenuCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

final class MenuTableViewCell: UITableViewCell, Reusable {
    static var identifier: String {
        return String(describing: self)
    }
    
    private let grayView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let menuLabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 16)
        return view
    }()
    
    private let disclosureImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return view
    }()
    
    private lazy var menuButton = {
        let menuButton = UIButton()
        let menus = [
            UIAction(title: "없음") { _ in
                NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["priority": 0])
            },
            UIAction(title: "낮음") { _ in
                NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["priority": 1])
            },
            UIAction(title: "중간") { _ in
                NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["priority": 2])
            },
            UIAction(title: "높음") { _ in
                NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["priority": 3])
            },
        
        ]
        let menu = UIMenu(title: "우선순위", children: menus)
        menuButton.menu = menu
        menuButton.showsMenuAsPrimaryAction = true
        return menuButton
    }()
    
    let smallImageView = {
        let view = UIImageView()
        return view
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(grayView)
        grayView.addSubview(menuLabel)
        grayView.addSubview(disclosureImageView)
        grayView.addSubview(menuButton)
        grayView.addSubview(smallImageView)
    }
    
    private func configureLayout() {
        grayView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.safeAreaInsets)
            $0.verticalEdges.equalTo(contentView.safeAreaInsets).inset(16)
        }
        
        menuLabel.snp.makeConstraints {
            $0.leading.equalTo(grayView).inset(12)
            $0.centerY.equalTo(grayView)
        }
        
        disclosureImageView.snp.makeConstraints {
            $0.centerY.equalTo(menuLabel)
            $0.size.equalTo(14)
            $0.trailing.equalTo(grayView).inset(12)
        }
        
        smallImageView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.width.equalTo(smallImageView.snp.height)
            $0.trailing.equalTo(disclosureImageView.snp.leading)
        }
        
        menuButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    
    func configureData(_ data: Todo, menuType: Todo.MenuList) {
        menuLabel.text = data.menuCellTitle(menuType: menuType)
        menuButton.isHidden = menuType != .priority
        smallImageView.isHidden = menuType != .image
        smallImageView.image = data.image
    }
    
    
}
