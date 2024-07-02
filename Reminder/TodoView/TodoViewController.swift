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
        todoTableView.register(TodoTableViewCell.self, forCellReuseIdentifier: TodoTableViewCell.id)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TodoTableViewCell.id, for: indexPath) as? TodoTableViewCell else { return UITableViewCell() }
        let data = list[indexPath.row]
        cell.configureData(data)
        return cell
    }
    
}
