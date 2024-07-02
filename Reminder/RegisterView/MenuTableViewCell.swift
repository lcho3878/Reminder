//
//  MenuCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell {
    
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
    
    static var identifier: String {
        return String(describing: self)
    }
    
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
    }
    
    func configureData(_ title: String) {
        menuLabel.text = title
    }
    
}
