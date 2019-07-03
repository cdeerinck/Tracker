//
//  colorFromImage.swift
//  Tracker
//
//  Created by Chuck Deerinck on 6/28/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

func normalizedImage(image:UIImage) -> UIImage {
    if image.imageOrientation == .up {
        return image
    }

    UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale);
    image.draw(in: CGRect(x: 0,y: 0, width: image.size.width, height: image.size.height))
    let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return normalizedImage
}

func colorFromImage(_ image:UIImage, frame: CGRect) -> UIColor {

    let normImage = normalizedImage(image: image)
    var rect = frame
//    print(frame)
//    print(normImage.size)
    let widthPct = frame.size.width / normImage.size.width
    let heightPct = frame.size.height / normImage.size.height
    let overallPct = widthPct > heightPct ? widthPct : heightPct
//    print(widthPct, heightPct, overallPct)
    rect.size.width /= overallPct
    rect.size.height /= overallPct
    rect.origin.x = (normImage.size.width / 2) - (rect.size.width / 2)
    rect.origin.y = (normImage.size.height / 2) - (rect.size.height / 2)
//    print(rect)

    if let imageRef = normImage.cgImage!.cropping(to: rect) { //was to: frame
        let midImage = UIImage(cgImage: imageRef) //Need to make the finalImage.imageOrientation the same as the original
        let finalImage = imageWith(image: midImage, newSize: frame.size)
        return UIColor(patternImage:finalImage)
    }

    return .red
}
