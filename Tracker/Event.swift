//
//  Event.swift
//  Tracker
//
//  Created by Chuck Deerinck on 6/26/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class Event:Codable {

//    static func < (lhs: Event, rhs: Event) -> Bool {
//        return lhs.nextDate < rhs.nextDate
//    }
//
//    static func == (lhs: Event, rhs: Event) -> Bool {
//        return (lhs.eventName == rhs.eventName) && (lhs.nextDate == rhs.nextDate)
//    }

    //todo: Implement Codable protocols, ideas are here: https://stackoverflow.com/questions/46197785/how-to-conform-uiimage-to-codable

    func ConvertImageToBase64String (img: UIImage) -> String {
        return img.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
    }

    func ConvertBase64StringToImage (imageBase64String:String?) -> UIImage? {
        if imageBase64String == nil { return nil }
        let imageData = Data.init(base64Encoded: imageBase64String!, options: .init(rawValue: 0))
        let image = UIImage(data: imageData!)
        return image!
    }

    enum CodingKeys: String, CodingKey
    {
        case nextDate = "nextDate"
        case eventName = "eventName"
        case recursType = "recursType"
        case recursNumber = "recursNumber"
        case eventPicture = "eventPicture"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        nextDate = try values.decode(Date.self, forKey: .nextDate)
        eventName = try values.decode(String.self, forKey: .eventName)
        recursType = try values.decode(Recurs.self, forKey: .recursType)
        recursNumber = try values.decode(Int.self, forKey: .recursNumber)
        eventPicture = ConvertBase64StringToImage(imageBase64String: try values.decodeIfPresent(String.self, forKey: .eventPicture) ?? nil)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(nextDate, forKey: .nextDate)
        try container.encode(eventName, forKey: .eventName)
        try container.encode(recursType, forKey: .recursType)
        try container.encode(recursNumber, forKey: .recursNumber)
        if eventPicture != nil {
            try container.encode(ConvertImageToBase64String(img: eventPicture!), forKey: .eventPicture)
        }
    }

    var nextDate:Date = Date()
    var eventName:String = ""
    var eventPicture:UIImage?
    var recursType:Recurs = .once
    var recursNumber:Int = 1

    var daysText:String {
        return String(abs(days))
    }

    var days:Int {
        get {
            return (Calendar.current.ordinality(of: .day, in: .era, for: nextDate) ?? 0) - (Calendar.current.ordinality(of: .day, in: .era, for: Date()) ?? 0)
        }
    }

    var sinceUntil:String {
        get {
            if days >= 0 { return "days until" } else { return "days since" }
        }
    }
    var textNextDate:String {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.dateFormat = "EEEE, MMMM d, yyyy"
            return dateFormatter.string(from: nextDate)
        }
    }

    init(eventName:String, nextDate:String, recursType:Recurs, recursNumber:Int) {
        self.eventName = eventName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        self.nextDate = (nextDate == "") ? Date() : dateFormatter.date(from: nextDate)!
        self.recursType = recursType
        self.recursNumber = recursNumber
    }

    func copyPictureFromClipboard() {
        if let pic = UIPasteboard.general.image { self.eventPicture = pic }
    }

    func getFromCameraRoll() {
        //todo: various solutions here: https://stackoverflow.com/questions/25510081/how-to-allow-user-to-pick-the-image-with-swift
    }
}
