//
//  TodoRepository.swift
//  Reminder
//
//  Created by 이찬호 on 7/5/24.
//

import Foundation
import RealmSwift

final class TodoRepository {
    
    private let realm = try! Realm()
    
    static let shared = TodoRepository()
    
    private init() {}
    
    func creadItem(_ data: Todo) {
        try! realm.write {
            realm.add(data)
        }
    }
    
    func readItems(with: Todo.HomeMenuList) -> Results<Todo> {
        switch with {
            
        case .today:
            return realm.objects(Todo.self).where {
                let calendar = Calendar.current
                let start = calendar.startOfDay(for: Date())
                if let end = calendar.date(byAdding: .day, value: 1, to: start) {
                    return $0.dueDate >= start && $0.dueDate < end
                }
                else {
                    return $0.dueDate == Date()
                }
            }
        case .expected:
            return realm.objects(Todo.self).where { $0.dueDate > Date() }
        case .all:
            return realm.objects(Todo.self)
        case .flag:
            return realm.objects(Todo.self).where { $0.isFlag == true }
        case .complete:
            return realm.objects(Todo.self).where { $0.isComplete == true }
        }
    }
    
    func updateItem(from: Todo?, to: Todo) {
        guard let from = from else { return }
        try! realm.write {
            from.copyProperties(other: to)
        }
    }
    
}
