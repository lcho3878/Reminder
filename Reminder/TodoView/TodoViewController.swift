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
    
    
    var with: Todo.HomeMenuList!
    
    var list: Results<Todo>!
    
    private func filterling(type: FilterType) {
        list = TodoRepository.shared.readItems(with: with)
        switch type {
        case .basic:
            break
        case .duedate, .priority, .title:
            list = list.sorted(byKeyPath: type.keyPath, ascending: type.ascending)
        }
        todoTableView.reloadData()
    }
    
    private lazy var filterButton = {
        let menus = FilterType.allCases.map { type in
            UIAction(title: type.rawValue) { _ in
                self.filterling(type: type)
            }
        }
        let menu = UIMenu(title: "정렬", children: menus)
        let view = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: nil, action: nil)
        view.menu = menu
        return view
    }()
    
    private lazy var categoryLabel = {
        let view = UILabel()
        view.text = with.rawValue
        view.textColor = .systemBlue
        view.font = .boldSystemFont(ofSize: 40)
        return view
    }()
    
    private let todoTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        list = TodoRepository.shared.readItems(with: with)
        NotificationCenter.default.addObserver(self, selector: #selector(todoUpdated), name: NSNotification.Name("todoUpdated"), object: nil)
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
        cell.tag = indexPath.row
        cell.delegate = self
        cell.configureData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let registerVC = RegisterViewController()
        registerVC.tempData = data
        registerVC.viewType = .modify
        let registerNav = UINavigationController(rootViewController: registerVC)
        present(registerNav, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let data = list[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "삭제") { _,_,_ in
            TodoRepository.shared.deleteItem(data: data)
            NotificationCenter.default.post(name: NSNotification.Name("todoUpdated"), object: nil)
            self.todoTableView.reloadData()
        }
        let flagUpdate = UIContextualAction(style: .normal, title: data.isFlag ? "깃발 해제" : "깃발 표시") { _, _, _ in
            TodoRepository.shared.updateItem(data: data) { data in
                data.isFlag.toggle()
                NotificationCenter.default.post(name: NSNotification.Name("todoUpdated"), object: nil)
                self.todoTableView.reloadData()
            }


        }
        let action = UISwipeActionsConfiguration(actions: [delete, flagUpdate])
        return action
    }
    
}

extension TodoViewController {
    @objc
    private func todoUpdated() {
        todoTableView.reloadData()
    }
}

extension TodoViewController {
    enum FilterType: String, CaseIterable {
        case basic = "기본"
        case duedate = "마감일"
        case title = "제목"
        case priority = "우선순위"
        
        var keyPath: String {
            switch self {
            case .basic:
                return ""
            case .duedate:
                return "dueDate"
            case .title:
                return "todoTitle"
            case .priority:
                return "priority"
            }
        }
        
        var ascending: Bool {
            switch self {
            case .basic, .duedate, .title:
                return true
            case .priority:
                return false
            }
        }
    }
}

extension TodoViewController: TodoTableViewCellDelegate {
    
    func updateData(_ index: Int) {
        let data = list[index]
        TodoRepository.shared.updateItem(data: data) { todo in
            todo.isComplete.toggle()
            NotificationCenter.default.post(name: NSNotification.Name("todoUpdated"), object: nil)
        }
    }
    
}
