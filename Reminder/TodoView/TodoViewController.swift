//
//  TodoViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class TodoViewController: BaseViewController {
    
    private let realm = try! Realm()
    
    private var list: Results<Todo>!
    
    private func filterling(title: String) {
        switch title {
        case "기본": list = realm.objects(Todo.self)
        case "마감일": list = realm.objects(Todo.self).sorted(byKeyPath: "todoTitle", ascending: true)
        default:
            break
        }
        todoTableView.reloadData()
    }
    
    private lazy var filterButton = {
        let menus = [
            UIAction(title: "기본") {
                self.filterling(title: $0.title)
            },
            UIAction(title: "마감일") { 
                self.filterling(title: $0.title)
            },
            UIAction(title: "제목") { _ in },
            UIAction(title: "우선순위") { _ in },
        
        ]
        let menu = UIMenu(title: "정렬", children: menus)
        let view = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: nil, action: nil)
        view.menu = menu
        return view
    }()
    
    private let categoryLabel = {
        let view = UILabel()
        view.text = "전체"
        view.textColor = .systemBlue
        view.font = .boldSystemFont(ofSize: 40)
        return view
    }()
    
    private let todoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        list = realm.objects(Todo.self)
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.rightBarButtonItem = filterButton
    }
    
    override func configureHierarhy() {
        view.addSubview(categoryLabel)
        view.addSubview(todoTableView)
    }
    
    override func configureLayout() {
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
        
        todoTableView.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension TodoViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.identifier)
        todoTableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.identifier, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        let data = list[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let registerVC = RegisterViewController()
        registerVC.todo = data
        registerVC.viewType = .modify
        let registerNav = UINavigationController(rootViewController: registerVC)
        present(registerNav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "삭제") { _,_,_ in
            try! self.realm.write{
                self.realm.delete(data)
            }
            self.todoTableView.reloadData()
        }
        let action = UISwipeActionsConfiguration(actions: [delete])
        return action
    }
    
}
