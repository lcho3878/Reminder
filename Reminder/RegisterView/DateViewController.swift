//
//  CalendarViewController.swift
//  Reminder
//
//  Created by 이찬호 on 7/3/24.
//

import UIKit
import SnapKit

final class DateViewController: BaseViewController {
    
    var storedDate: Date?
    
    private lazy var datePicker = {
        let view = UIDatePicker()
        view.preferredDatePickerStyle = .inline
        view.locale = Locale(identifier: "ko-KR")
        view.timeZone = TimeZone(abbreviation: "GMT+9:00")
        view.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        view.date = storedDate ?? Date()
        return view
    }()
    
    private lazy var dismissButton = {
        let view = UIBarButtonItem(title: BarButtonType.dismiss.rawValue, style: .plain, target: self, action: #selector(dismissButtonClicked))
        return view
    }()
    
    private lazy var confirmButton = {
        let view = UIBarButtonItem(title: BarButtonType.confirm.rawValue, style: .plain, target: self, action: #selector(confirmButtonClicked))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = confirmButton
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

    }
    
    @objc
    private func dismissButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func confirmButtonClicked() {
        NotificationCenter.default.post(name: NSNotification.Name("TodoReceived"), object: nil, userInfo: ["date": datePicker.date])
        navigationController?.popViewController(animated: true)
    }

}


