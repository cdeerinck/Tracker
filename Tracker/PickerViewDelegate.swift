//
//  PickerViewDelegate.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/2/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class RecursPickerViewDelegate:NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var event:Event

    init(for event:Event) {
        self.event = event
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // every x nths
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 1
        case 1:
            // should be 30 for days, 11 for months, and 20 for years, based on component 2
            return 30
        case 2:
            return 3
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        switch component {
        case 1:
            return 40
        default:
            return 100
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 1:
            return String(row+1)
        case 2:
            return ["days","months","years"][row]
        default:
            return ["every"][row]
        }
    }

    func setup (_ pickerView: UIPickerView) {
        pickerView.selectRow(0, inComponent: 0, animated: true)
        pickerView.selectRow(event.recursNumber, inComponent: 1, animated: true)
        switch event.recursType {
        case .everyXDays:
            pickerView.selectRow(0, inComponent: 2, animated: true)
        case .everyXMonths:
            pickerView.selectRow(1, inComponent: 2, animated: true)
        case .everyXYears:
            pickerView.selectRow(2, inComponent: 2, animated: true)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 1:
            event.recursNumber = row
        case 2:
            switch row {
            case 0:
                event.recursType = .everyXDays
            case 1:
                event.recursType = .everyXMonths
            default:
                event.recursType = .everyXYears
            }
        default:
            return
        }
    }
}
