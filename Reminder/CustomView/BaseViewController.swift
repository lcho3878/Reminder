//
//  BaseViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureHierarhy()
        configureLayout()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func configureHierarhy() {}
    
    func configureLayout() {}
    
}

extension BaseViewController {
    enum BarButtonType: String {
        case dismiss = "취소"
        case confirm = "확인"
    }
}
