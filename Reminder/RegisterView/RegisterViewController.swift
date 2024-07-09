//
//  RegisterViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import SnapKit
import PhotosUI


final class RegisterViewController: BaseViewController {
    
    var viewType: ViewType!
    
    var storedFolder: Folder?
    
    let todo = Todo(todoTitle: "", todoMemo: nil, dueDate: nil, priority: 0, tag: nil)
    
    var tempData: Todo?
    
    private lazy var dismissButton = {
        let view = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissButtonClicked))
        return view
    }()
    
    private lazy var rightBarButton = {
        let view = UIBarButtonItem(title: viewType.rawValue, style: .plain, target: self, action: #selector(addButtonClicked))
        view.isEnabled = viewType == .modify
        view.tintColor = viewType == .modify ? .systemBlue : .lightGray
        return view
    }()
    
    private lazy var titleTextField = {
        let view = UIPaddingTextField()
        view.placeholder = "제목"
        view.text = viewType == .modify ? tempData?.todoTitle : nil
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
    
    private lazy var contentTextView = {
        let view = UITextView()
        view.text = viewType == .modify ? tempData?.todoMemo : nil
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
        configureTempData(tempData)

        NotificationCenter.default.addObserver(self, selector: #selector(todoReceived), name: NSNotification.Name("TodoReceived"), object: nil)
    }
    
    private func configureTempData(_ tempData: Todo?) {
        guard let tempData else { return }
            todo.copyProperties(other: tempData)
        if let image = DataManager.shared.loadImageToDocument(filename: tempData.id.stringValue) {
            todo.image = image
        }
        menuTableView.reloadData()
    }
    
    @objc func todoReceived(notification: NSNotification) {
        if let date = notification.userInfo?["date"] as? Date {
            todo.dueDate = date
        }
        if let tag = notification.userInfo?["tag"] as? String {
            todo.tag = tag.isEmpty ? nil : tag
        }
        if let priority = notification.userInfo?["priority"] as? Int {
            todo.priority = priority
        }
        if let folder = notification.userInfo?["folder"] as? Folder {
            storedFolder = folder
        }
        menuTableView.reloadData()
    }
    
    override func configureView() {
        super.configureView()
        title = viewType.navigationTitle
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = rightBarButton
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
    
    typealias MenuList = Todo.MenuList
    
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
        let menuType = MenuList.allCases[indexPath.row]
        cell.configureData(todo, menuType: menuType)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuType = MenuList.allCases[indexPath.row]
        switch menuType {
        case .date:
            let dateVC = DateViewController()
            dateVC.storedDate = todo.dueDate
            navigationController?.pushViewController(dateVC, animated: true)
        case .tag:
            let tagVC = TagViewController()
            tagVC.storedTag = todo.tag
            let tagNav = UINavigationController(rootViewController: tagVC)
            present(tagNav, animated: true)
        case .image:
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .any(of: [.screenshots, .images])
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            present(picker, animated: true)
        case .priority:
            break
        case .folder:
            let folderSelectVc = FolderSelectViewController()
            folderSelectVc.storedFolder = todo.folder.first
            navigationController?.pushViewController(folderSelectVc, animated: true)
            break
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
        guard let title = titleTextField.text,
              let memo = contentTextView.text else { return }
        todo.todoTitle = title
        todo.todoMemo = memo.isEmpty ? nil : memo
        if viewType == .register {
            TodoRepository.shared.creadItem(todo, folder: storedFolder)
            DataManager.shared.saveImageToDocument(image: todo.image, filename: todo.id.stringValue)
        }
        else {
            guard let tempData else { return }
            TodoRepository.shared.updateItem(from: tempData, to: todo)
            DataManager.shared.saveImageToDocument(image: tempData.image, filename: tempData.id.stringValue)
        }

        NotificationCenter.default.post(name: NSNotification.Name("todoUpdated"), object: nil)
        dismiss(animated: true)
    }
    
    @objc
    private func titleTextFieldChanged() {
        guard let text = titleTextField.text else { return }
        rightBarButton.isEnabled = !text.isEmpty
        rightBarButton.tintColor = text.isEmpty ? .lightGray : .systemBlue
    }
}

extension RegisterViewController {
    enum ViewType: String {
        case register = "추가"
        case modify = "수정"
        
        var navigationTitle: String {
            switch self {
            case .register:
                return "새로운 할 일"
            case .modify:
                return "세부사항"
            }
        }
    }
}

extension RegisterViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider,
              itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
        itemProvider.loadObject(ofClass: UIImage.self) { image, error in
            DispatchQueue.main.async {
                self.todo.image = image as? UIImage
                self.menuTableView.reloadData()
            }
         
        }
    }
    
}
