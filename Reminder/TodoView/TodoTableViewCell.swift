//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

final class TodoTableViewCell: UITableViewCell {
    
    private let titleLabel = {
        let view = UILabel()
        return view
    }()
    
    static var id: String {
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
        contentView.addSubview(titleLabel)
    }
    
    private func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configureData(_ data: Todo) {
        titleLabel.text = data.todoTitle
    }
    
}
