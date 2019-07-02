//
//  getDocumentsDirectory.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/1/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
