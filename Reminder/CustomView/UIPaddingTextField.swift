//
//  UIPaddingTextField.swift
//  Reminder
//
//  Created by 이찬호 on 7/2/24.
//

import UIKit

final class UIPaddingTextField: UITextField {
    
    var insetX: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    var insetY: CGFloat = 0 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, insetY)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRectInset(bounds, insetX, insetY)
    }
    
}
