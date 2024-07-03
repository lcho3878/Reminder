//
//  Reusable.swift
//  Reminder
//
//  Created by 이찬호 on 7/3/24.
//

import Foundation

protocol Reusable: AnyObject {
    static var identifier: String { get }
}
