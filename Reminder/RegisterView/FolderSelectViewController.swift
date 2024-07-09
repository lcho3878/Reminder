//
//  FolderSelectViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/8/24.
//

import UIKit
import SnapKit

class FolderSelectViewController: BaseViewController {
    
    var storedFolder: Folder?
    
    let folders = TodoRepository.shared.readFolders()
    
    private let folderTableView = UITableView()
    
    private lazy var confirmButton = {
        let view = UIBarButtonItem(title: BarButtonType.confirm.rawValue, style: .plain, target: self, action: #selector(confirmButtonClicked))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        print("folder select, \(storedFolder?.name)")
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.rightBarButtonItem = confirmButton
    }
    
    override func configureHierarhy() {
        view.addSubview(folderTableView)
    }
    
    override func configureLayout() {
        folderTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

extension FolderSelectViewController {
    @objc
    private func confirmButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["folder": storedFolder])
        navigationController?.popViewController(animated: true)
    }
}

extension FolderSelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func configureTableView() {
        folderTableView.delegate = self
        folderTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "FolderCell")
        let folder = folders[indexPath.row]
        cell.textLabel?.text = folder.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folder = folders[indexPath.row]
        storedFolder = folder
    }
    
    
    
    
}
