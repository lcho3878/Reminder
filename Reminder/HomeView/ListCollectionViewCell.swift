//
//  ListCollectionViewCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/3/24.
//

import UIKit
import SnapKit

final class ListCollectionViewCell: UICollectionViewCell, Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private let mainView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let iconImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "calendar.circle.fill")
        return view
    }()
    
    private let listTitleLabel = {
        let view = UILabel()
        view.text = "오늘"
        view.textColor = .lightGray
        return view
    }()
    
    private let countLabel = {
        let view = UILabel()
        view.text = "0"
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(mainView)
        mainView.addSubview(iconImageView)
        mainView.addSubview(listTitleLabel)
        mainView.addSubview(countLabel)
    }
    
    private func configureLayout() {
        mainView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(4)
            $0.height.equalToSuperview().dividedBy(2)
            $0.width.equalTo(iconImageView.snp.height)
        }
        
        listTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView)
            $0.top.equalTo(iconImageView.snp.bottom).offset(4)
        }
        
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalTo(iconImageView)
        }
        
    }
    
}
