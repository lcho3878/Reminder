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
    
    private lazy var dismissButton = {
        let view = UIBarButtonItem(title: BarButtonType.dismiss.rawValue, style: .plain, target: self, action: #selector(dismissButtonClicked))
        return view
    }()
    
    private lazy var confirmButton = {
        let view = UIBarButtonItem(title: BarButtonType.confirm.rawValue, style: .plain, target: self, action: #selector(confirmButtonClicked))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["tag": tagTextField.text!])
//    }
    
    override func configureView() {
        super.configureView()
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = confirmButton
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

extension TagViewController {
    @objc
    private func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc
    private func confirmButtonClicked() {
        guard let tag = tagTextField.text else { return }
        NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["tag": tag])
        dismiss(animated: true)
    }
}
