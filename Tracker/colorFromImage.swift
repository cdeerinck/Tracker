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
    rect.origin.x*=normImage.scale
    rect.origin.y*=normImage.scale
    rect.size.width*=normImage.scale
    rect.size.height*=normImage.scale
    rect.origin.x = (normImage.size.width / 2) - (frame.width / 2)
    rect.origin.y = (normImage.size.height / 2) - (frame.height / 2)

    if let imageRef = normImage.cgImage!.cropping(to: rect) { //was to: frame
        let finalImage = UIImage(cgImage: imageRef) //Need to make the finalImage.imageOrientation the same as the original
        return UIColor(patternImage:finalImage)
    }
    //UIImage(cgImage: imageRef!, scale: image.scale, orientation: image.imageOrientation)
    //let finalImage = image.CGImageCroppingTo(frame)
//    UIGraphicsBeginImageContext(frame.size)
//    image.draw(in: frame)
//    let finalImage = UIGraphicsGetImageFromCurrentImageContext()!
//    UIGraphicsEndImageContext()
    return .red
}

