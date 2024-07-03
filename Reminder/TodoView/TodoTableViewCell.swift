//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

final class TodoTableViewCell: UITableViewCell {
    
    static var id: String {
        return String(describing: self)
    }
    
    
    private let titleLabel = {
        let view = UILabel()
        return view
    }()
    
    private let memoLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        return view
    }()
    
    private let dateLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        return view
    }()
    
    private let tagLabel = {
        let view = UILabel()
        view.textColor = .systemBlue
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
        contentView.addSubview(titleLabel)
        contentView.addSubview(memoLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.leading.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            $0.height.lessThanOrEqualTo(44)
        }
        
        memoLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.height.lessThanOrEqualTo(44)
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel)
            $0.height.lessThanOrEqualTo(44)
            $0.top.equalTo(memoLabel.snp.bottom).offset(4)
            $0.bottom.equalTo(contentView.safeAreaInsets).inset(4)
        }
        
        tagLabel.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(8)
            $0.height.verticalEdges.equalTo(dateLabel)
        }
    
    }
    
    func configureData(_ data: Todo) {
        titleLabel.text = data.todoTitle
        memoLabel.text = data.todoMemo
        dateLabel.text = data.dueDate?.formatted()
        tagLabel.text = data.tag
    }
    
}
