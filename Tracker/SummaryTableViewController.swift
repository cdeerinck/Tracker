//
//  SummaryTableViewController.swift
//  Tracker
//
//  Created by Chuck Deerinck on 6/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class SummaryTableViewController: UITableViewController {

//class SummaryTableView: UITableView {

    @IBOutlet var summaryView: UITableView!

    override func viewDidLoad() {
        readFromFile()

        if events.eventArray.count == 0 {
            events.eventArray.append(Event(eventName: "Alpha fools", nextDate: "04/01/2020", recursType: .everyXYears, recursNumber: 1))
            events.eventArray.append(Event(eventName: "Beta weekly", nextDate: "02/01/2019", recursType: .everyXDays, recursNumber: 7))
            events.eventArray.append(Event(eventName: "Gamma", nextDate: "08/05/2019", recursType: .once, recursNumber: 0))
        }
        events.eventArray.sort { $0.nextDate < $1.nextDate}
    }

    override func viewWillAppear(_ animated: Bool) {
        events.eventArray.sort() { $0.days < $1.days }
        writeToFile()
        summaryView.reloadData()
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Summary Cell", for: indexPath)
        if events.eventArray[indexPath.row].eventPicture != nil {
            cell.backgroundColor = colorFromImage(events.eventArray[indexPath.row].eventPicture!, frame: cell.frame)
        }
        if let daysLabel = cell.viewWithTag(1) as? UILabel {
            daysLabel.text = String(events.eventArray[indexPath.row].daysText)
        }
        if let daysScenceUntilLabel = cell.viewWithTag(2) as? UILabel {
            daysScenceUntilLabel.text = String(events.eventArray[indexPath.row].sinceUntil)
        }
        if let eventNameLabel = cell.viewWithTag(3) as? UILabel {
            eventNameLabel.text = String(events.eventArray[indexPath.row].eventName)
        }
        if let actualDateLabel = cell.viewWithTag(4) as? UILabel {
            actualDateLabel.text = String(events.eventArray[indexPath.row].textNextDate)
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.eventArray.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    @IBAction func addItem(_ sender: Any) {
        events.eventArray.append(Event(eventName: "New Item", nextDate: "", recursType: .once, recursNumber: 1))
        let indexPath = IndexPath(row: events.eventArray.count - 1, section: 0)
        summaryView.beginUpdates()
        summaryView.insertRows(at: [indexPath], with: .automatic)
        summaryView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            events.eventArray.remove(at: indexPath.row)
            summaryView.beginUpdates()
            summaryView.deleteRows(at: [indexPath], with: .automatic)
            summaryView.endUpdates()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dtvc = segue.destination as? DetailTableViewController {
            if let index = summaryView.indexPathForSelectedRow {
                dtvc.event =  events.eventArray[index.row]
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Summary to Detail", sender: self)
    }

//override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if let navigationController = segue.destination as? UINavigationController,
//        let editContactViewController = navigationController.viewControllers.first as? EditContactViewController {
//        editContactViewController.contact = contact
//    }

    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        if let editedIndexPath = summaryView.indexPathForSelectedRow {
            tableView.reloadRows(at: [editedIndexPath], with: .fade)
        }
    }
}
