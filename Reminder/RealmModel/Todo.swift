//
//  Todo.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    enum MenuList: String, CaseIterable{
        case date = "마감일"
        case tag = "태그"
        case priority = "우선 순위"
        case image = "이미지 추가"
    }
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var todoTitle: String
    @Persisted var todoMemo: String?
    @Persisted var dueDate: Date?
    @Persisted var priority: Int
    @Persisted var tag: String?
    
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
            return menuType.rawValue
        case .image:
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
}
