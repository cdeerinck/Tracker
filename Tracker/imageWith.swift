//
//  imageWithImage.swift
//  Tracker
//
//  Created by Chuck Deerinck on 7/2/19.
//  Copyright © 2019 Chuck Deerinck. All rights reserved.
//

import Foundation
import UIKit

func imageWith(image: UIImage, newSize: CGSize) -> UIImage {
    let renderer = UIGraphicsImageRenderer(size: newSize)
    let newImage = renderer.image { _ in
        image.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
    }

    return newImage
}
// // Or this alternative
//        func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
//            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
//            image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
//            let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
//            UIGraphicsEndImageContext()
//            return newImage
//        }
