//
//  TextViewDelegate.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/2/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

class TextViewDelegate: NSObject, UITextViewDelegate {
   
    var event:Event

    init(for event:Event) {
        self.event = event
    }

    func textViewDidChange(_ textView: UITextView) {
        event.eventName = textView.text
    }
}
