//
//  RegisterViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class RegisterViewController: BaseViewController {
    
    private let realm = try! Realm()
    
    private lazy var dismissButton = {
        let view = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissButtonClicked))
        return view
    }()
    
    private lazy var addButton = {
        let view = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addButtonClicked))
        view.isEnabled = false
        view.tintColor = .lightGray
        return view
    }()
    
    private lazy var titleTextField = {
        let view = UIPaddingTextField()
        view.placeholder = "제목"
        view.font = .systemFont(ofSize: 16)
        view.insetX = 8
        view.insetY = 8
        view.backgroundColor = .systemGray5
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.cornerRadius = 8
        view.addTarget(self, action: #selector(titleTextFieldChanged), for: .editingChanged)
        return view
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let contentTextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        view.backgroundColor = .systemGray5
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let menuTableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        view.separatorStyle = .none
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func configureView() {
        super.configureView()
        title = "새로운 할 일"
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = addButton
    }

    override func configureHierarhy() {
        view.addSubview(titleTextField)
        view.addSubview(lineView)
        view.addSubview(contentTextView)
        view.addSubview(menuTableView)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(12)
            $0.height.equalTo(40)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(titleTextField.snp.bottom)
            $0.horizontalEdges.equalTo(titleTextField)
            $0.height.equalTo(0.2)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.horizontalEdges.equalTo(titleTextField)
            $0.height.equalTo(120)
        }
        
        menuTableView.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(titleTextField)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum MenuList: String, CaseIterable{
        case date = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case image = "이미지 추가"
    }
    
    private func configureTableView() {
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else { return UITableViewCell() }
        let data = MenuList.allCases[indexPath.row].rawValue
        cell.configureData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = MenuList.allCases[indexPath.row]
        switch data {
        case .date:
            let calVC = CalendarViewController()
            navigationController?.pushViewController(calVC, animated: true)
        case .tag:
            print(data.rawValue)
        case .priority:
            print(data.rawValue)
        case .image:
            print(data.rawValue)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension RegisterViewController {
    @objc
    private func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc
    private func addButtonClicked() {
        guard let title = titleTextField.text else { return }
        let todo = Todo(todoTitle: title, todoMemo: nil, dueDate: nil, priority: 0, tag: nil)
        try! realm.write {
            realm.add(todo)
        }
        dismiss(animated: true)
    }
    
    @objc
    private func titleTextFieldChanged() {
        guard let text = titleTextField.text else { return }
        addButton.isEnabled = !text.isEmpty
        addButton.tintColor = text.isEmpty ? .lightGray : .systemBlue
    }
}
