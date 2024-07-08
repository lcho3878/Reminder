//
//  Folder.swift
//  Reminder
//
//  Created by 이찬호 on 7/8/24.
//

import Foundation
import RealmSwift

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var todos: List<Todo>
}
