//
//  Observable.swift
//  Reminder
//
//  Created by 이찬호 on 7/9/24.
//

import Foundation

final class Observable<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T) {
        self.value = value
    }
    func bind(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
