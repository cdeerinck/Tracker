//
//  DetailTableViewController.swift
//  Tracker
//
//  Created by Chuck Deerinck on 6/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class DetailTableViewController: UITableViewController {

    var event:Event?
    var isDatePickerRowHidden = true
    lazy var textViewDelegate = TextViewDelegate(for: event!)
    lazy var recursPickerViewDelegate = RecursPickerViewDelegate(for: event!)

    let pickerData = ["Once","Days","Months","Years"]

    @IBOutlet var detailTableView: UITableView!

    var datePicker: UIDatePicker!
    var textView: UITextView?

    override func viewDidLoad() {
        if let pic = event?.eventPicture {
            //self.view.backgroundColor = colorFromImage(pic, frame: self.view.frame)
            self.tableView.backgroundView = UIImageView(image: pic)
            self.tableView.backgroundView?.contentMode = .scaleAspectFill
            detailTableView.tableFooterView = UIView(frame: CGRect.zero)
        } else {
            self.tableView.backgroundColor = .white
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1 {
            isDatePickerRowHidden.toggle()
        } else {
            isDatePickerRowHidden = true
        }
        let pickerIndexPath = IndexPath(row: 2, section: indexPath.section)
        tableView.reloadRows(at: [pickerIndexPath], with: .middle)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.section, indexPath.row)
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Event Cell", for: indexPath)
            if let eventText = cell.viewWithTag(1) as? UITextView {
                eventText.text = event?.eventName
                textView = eventText
                textView?.delegate = textViewDelegate
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Date Cell", for: indexPath)
            if let dateLabel = cell.viewWithTag(1) as? UILabel {
                dateLabel.text = event?.textNextDate
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Date Picker Cell", for: indexPath)
            if let tempDatePicker = cell.viewWithTag(1) as? UIDatePicker {
                tempDatePicker.date = event!.nextDate
                tempDatePicker.datePickerMode = .date
                datePicker = tempDatePicker
            }
            return cell
        case 3:let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Recurs Cell", for: indexPath)
        if let recursPicker = cell.viewWithTag(1) as? UIPickerView {
            recursPicker.dataSource = recursPickerViewDelegate
            recursPicker.delegate = recursPickerViewDelegate
            recursPickerViewDelegate.setup(recursPicker)
        }
            return cell
        default: //only really used for case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Detail Picture Cell", for: indexPath)
            if let clipboardButton = cell.viewWithTag(1) as? UIButton {
                if let cameraButton = cell.viewWithTag(2) as? UIButton {
                    clipboardButton.backgroundColor = UIColor(white: 1, alpha: 0.5)
                    cameraButton.backgroundColor = UIColor(white: 1, alpha: 0.25)
                }
            }
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 113
        case 1:
            return 40
        case 2:
            if isDatePickerRowHidden {
                return 0
            } else {
                return 160
            }
        case 3:
            return 94
        default:
            return 99
         }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(white: 1, alpha: 0.25)
    }

    @IBAction func fromClipboard(_ sender: Any) {
        if let pic = UIPasteboard.general.image {
            event!.eventPicture = pic
            self.view.backgroundColor = colorFromImage(pic, frame: self.view.frame)
        }
    }
    
    @IBAction func datePickervalueChanged(_ sender: Any) {
        event?.nextDate = datePicker.date
        let pickerIndexPath = IndexPath(row: 1, section: 0)
        tableView.reloadRows(at: [pickerIndexPath], with: .none)
    }

    @IBAction func fromCameraRoll(_ sender: Any) {
    }
    

}
