//
//  CalendarViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/3/24.
//

import UIKit
import SnapKit

final class DateViewController: BaseViewController {
    
    private lazy var datePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .inline
        view.locale = Locale(identifier: "ko-KR")
        view.timeZone = TimeZone(abbreviation: "GMT+0:00")
        view.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["date": datePicker.date])
    }
    
    override func configureView() {
        super.configureView()
    }
    
    override func configureHierarhy() {
        view.addSubview(datePicker)
    }
    
    override func configureLayout() {
        datePicker.snp.makeConstraints{
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(400)
        }
    }
    
}

extension DateViewController {
    @objc
    private func datePickerValueChanged(_ sender: UIDatePicker) {
        print(sender.date)
    }
}

