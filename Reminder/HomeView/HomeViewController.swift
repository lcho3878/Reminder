//
//  ViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
    
    private let searchBar = {
        let view = UISearchBar()
        view.searchBarStyle = .minimal
        return view
    }()
    
    private lazy var tempButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "임시버튼"
        let bt = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.tempButtonClicked()
        }))
        return bt
    }()
    
    private lazy var newTaskButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "새로운 미리 알림"
        configuration.baseForegroundColor = .systemBlue
        configuration.image = UIImage(systemName: "plus.circle.fill")
        configuration.imagePadding = 8
        let bt = UIButton(configuration: configuration, primaryAction: UIAction(handler: { _ in
            self.newTaskButtonClicked()
        }))
        return bt
    }()
    
    private let newListButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "목록 추가"
        configuration.baseForegroundColor = .systemBlue
        let bt = UIButton(configuration: configuration)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func configureHierarhy() {
        view.addSubview(searchBar)
        view.addSubview(tempButton)
        view.addSubview(newTaskButton)
        view.addSubview(newListButton)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        tempButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        newTaskButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        newListButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

}

extension HomeViewController {
    private func newTaskButtonClicked() {
        let registerVC = RegisterViewController()
        let registerNav = UINavigationController(rootViewController: registerVC)
        present(registerNav, animated: true)
    }
    
    private func tempButtonClicked() {
        let todoVC = TodoViewController()
        navigationController?.pushViewController(todoVC, animated: true)
    }
}

