//
//  readFromFile.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/1/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func readFromFile() -> Events {
    let filename = getDocumentsDirectory().appendingPathComponent("Data.json")
    do {
        let data = try Data(contentsOf: filename)

        let events:Events = try JSONDecoder().decode(Events.self, from:data)
        return events
        } catch {
            //error handling here...
        }
        return Events()
}
