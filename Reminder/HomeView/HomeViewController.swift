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
    
    private let listCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let n: CGFloat = 2
        let spacing: CGFloat = 2
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        let width = (UIScreen.main.bounds.width - ((n + 1) * spacing)) / n
        layout.itemSize = CGSize(width: width , height: 80)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
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
        configureCollectionView()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func configureHierarhy() {
        view.addSubview(searchBar)
        view.addSubview(listCollectionView)
        view.addSubview(newTaskButton)
        view.addSubview(newListButton)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        newTaskButton.snp.makeConstraints {
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        newListButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        listCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(newTaskButton.snp.top).offset(8)
        }
    }

}

extension HomeViewController {
    private func newTaskButtonClicked() {
        let registerVC = RegisterViewController()
        let registerNav = UINavigationController(rootViewController: registerVC)
        present(registerNav, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    private func configureCollectionView() {
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as? ListCollectionViewCell else { return UICollectionViewCell() }
        let data = Todo.makeList()
        cell.configureData(data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let todoVC = TodoViewController()
        navigationController?.pushViewController(todoVC, animated: true)
    }
    
}

