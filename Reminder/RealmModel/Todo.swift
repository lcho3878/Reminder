//
//  Todo.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit
import RealmSwift

class Todo: Object {
    enum MenuList: String, CaseIterable{
        case date = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case image = "이미지 추가"
        case folder = "목록 선택"
    }
    
    enum HomeMenuList: String, CaseIterable {
        case today = "오늘"
        case expected = "예정"
        case all = "전체"
        case flag = "깃발 표시"
        case complete = "완료됨"
        
        var iconImage: UIImage? {
            switch self {
            case .today:
                return  UIImage(systemName: "calendar")
            case .expected:
                return UIImage(systemName: "calendar")
            case .all:
                return UIImage(systemName: "tray.fill")
            case .flag:
                return UIImage(systemName: "flag.fill")
            case .complete:
                return UIImage(systemName: "checkmark")
            }
        }
        
        var iconBackgroundColor: UIColor {
            switch self {
            case .today:
                return .systemBlue
            case .expected:
                return .systemRed
            case .all:
                return .lightGray
            case .flag:
                return .systemYellow
            case .complete:
                return .gray
            }
        }
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var todoTitle: String
    @Persisted var todoMemo: String?
    @Persisted var dueDate: Date?
    @Persisted var priority: Int
    @Persisted var tag: String?
    @Persisted var isFlag: Bool
    @Persisted var isComplete: Bool
    
    @Persisted(originProperty: "todos") var folder: LinkingObjects<Folder>
    
    var image: UIImage?
    
    var titleString: NSAttributedString {
        let bangs = String(repeating: "!", count: priority)
        let spacing = priority == 0 ? "" : " "
        let attributedString = NSMutableAttributedString(string: bangs + spacing + todoTitle)
        let range = NSRange(location: 0, length: priority)
        attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: range)
        return attributedString
    }
    
    var tagString: String? {
        guard let tag else { return nil }
        return "#" + tag
    }
    
    var priorityString: String {
        switch priority{
        case 1: return ": 낮음"
        case 2: return ": 중간"
        case 3: return ": 높음"
        default: return ""
        }
    }
    
    func menuCellTitle(menuType: MenuList) -> String {
        switch menuType {
        case .date:
            if let dueDate {
                return menuType.rawValue + ": " + dueDate.formatted()
            }
            else {
                return menuType.rawValue
            }
        case .tag:
            if let tag {
                return menuType.rawValue + ": " + tag
            }
            else {
                return menuType.rawValue
            }
        case .priority:
            return menuType.rawValue + priorityString
        case .image:
            return menuType.rawValue
        case .folder:
            return menuType.rawValue
        }
    }
    
    convenience init(todoTitle: String, todoMemo: String?, dueDate: Date?, priority: Int, tag: String?) {
        self.init()
        self.todoTitle = todoTitle
        self.todoMemo = todoMemo
        self.dueDate = dueDate
        self.priority = priority
        self.tag = tag
    }
    
    func copyProperties (other: Todo) {
        self.todoTitle = other.todoTitle
        self.todoMemo = other.todoMemo
        self.dueDate = other.dueDate
        self.priority = other.priority
        self.tag = other.tag
        self.isFlag = other.isFlag
        self.isComplete = other.isComplete
        self.image = other.image
//        self.folder = other.folder
    }
}
