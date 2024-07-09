//
//  DateViewModel.swift
//  Reminder
//
//  Created by 이찬호 on 7/9/24.
//

import Foundation

final class DateViewModel {
    
    var inputDate = Observable<Date?>(nil)
    var outputDate = Observable<String?>(nil)
    
    init() {
        inputDate.bind { date in
            self.outputDate.value = date?.formatted()
        }
    }
}
