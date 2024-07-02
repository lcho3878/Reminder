//
//  Todo.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import Foundation
import RealmSwift

class Todo: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted(indexed: true) var todoTitle: String
    @Persisted var todoMemo: String?
    @Persisted var dueDate: Date?
    
    convenience init(id: ObjectId, todoTitle: String, todoMemo: String?, dueDate: Date?) {
        self.init()
        self.id = id
        self.todoTitle = todoTitle
        self.todoMemo = todoMemo
        self.dueDate = dueDate
    }
}
