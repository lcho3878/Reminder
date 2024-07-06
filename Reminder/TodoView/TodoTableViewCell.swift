//
//  TodoTableViewCell.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

protocol TodoTableViewCellDelegate: AnyObject {
    func updateData(_ index: Int)
}

final class TodoTableViewCell: UITableViewCell, Reusable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    weak var delegate: TodoTableViewCellDelegate?
    
    private lazy var completeButton = {
        let view = UIButton()
        view.addTarget(self, action: #selector(completeButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private let horizontalStackView = {
        let view = UIStackView()
        view.distribution = .equalSpacing
        view.spacing = 0
        return view
    }()
    
    private let verticalStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.spacing = 4
        view.axis = .vertical
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        return view
    }()
    
    private let memoLabel = {
        let view = UILabel()
        view.textColor = .lightGray
        return view
    }()
    
    private let bottomStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.spacing = 8
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
    
    private let cellImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.addSubview(completeButton)
        horizontalStackView.addSubview(verticalStackView)
        horizontalStackView.addSubview(cellImageView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(memoLabel)
        verticalStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(dateLabel)
        bottomStackView.addArrangedSubview(tagLabel)

    }
    
    private func configureLayout() {
        
        horizontalStackView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.width.equalTo(40)
        }
        
        cellImageView.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(verticalStackView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.height.lessThanOrEqualTo(50)
            $0.width.equalTo(cellImageView.snp.height)
            $0.top.greaterThanOrEqualTo(contentView.safeAreaLayoutGuide).offset(8)
            $0.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.centerY.equalTo(completeButton)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(8)
            $0.leading.equalTo(completeButton.snp.trailing)
        }
    
    }
    
    func configureData(_ data: Todo) {
        titleLabel.attributedText = data.titleString
        memoLabel.text = data.todoMemo
        dateLabel.text = data.dueDate?.formatted()
        tagLabel.text = data.tagString
        completeButton.setImage(UIImage(systemName: data.isComplete ? "circle.fill" : "circle"), for: .normal)
        cellImageView.image = DataManager.shared.loadImageToDocument(filename: data.id.stringValue)
        configureHidden(data)
    }
    
    private func configureHidden(_ data: Todo) {
        memoLabel.isHidden = data.todoMemo == nil
        dateLabel.isHidden = data.dueDate == nil
        tagLabel.isHidden = data.tag == nil
        bottomStackView.isHidden = tagLabel.isHidden && dateLabel.isHidden
        cellImageView.isHidden = cellImageView.image == nil
    }
}

extension TodoTableViewCell {
    @objc
    private func completeButtonClicked() {
        delegate?.updateData(tag)
    }
}
