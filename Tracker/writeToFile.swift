//
//  WriteToFile.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/1/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation



func writeToFile() {
    if let encodedData = try? JSONEncoder().encode(events) {
        let filename = getDocumentsDirectory().appendingPathComponent("Data.json")
        do {
            try encodedData.write(to: filename)
            //print(String(data: encodedData, encoding: .utf8)!)
        }
        catch {
            print("Failed to write JSON data: \(error.localizedDescription)")
        }
    }
}
