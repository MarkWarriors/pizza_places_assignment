//
//  PPImages.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 05/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

struct PPImages {
    struct Marker {
        public static let icon = ImageUtils.imageWithImage(image: UIImage(named: "MapMarker")!, scaledToSize: CGSize(width: 26, height: 39))
    }
    
    struct Navigation {
        public static let backButton = UIImage(named: "BackBtn")
    }
}


class ImageUtils {
    static func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
