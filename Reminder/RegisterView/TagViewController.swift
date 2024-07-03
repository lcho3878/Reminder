//
//  TagViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/3/24.
//

import UIKit
import SnapKit

final class TagViewController: BaseViewController {
    
    private let tagTextField = {
        let view = UIPaddingTextField()
        view.insetX = 16
        view.placeholder = "새로운 태그 추가..."
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        title = "태그"
    }
    
    override func configureHierarhy() {
        view.addSubview(tagTextField)
    }
    
    override func configureLayout() {
        tagTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
    }
    
}
