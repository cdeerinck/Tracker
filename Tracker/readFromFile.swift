//
//  readFromFile.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/1/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func readFromFile() {
    let filename = getDocumentsDirectory().appendingPathComponent("Data.json")
    do {
        let data = try Data(contentsOf: filename)

        events = try JSONDecoder().decode(Events.self, from:data)
        } catch {
            //error handling here...
        }
}
