//
//  File.swift
//  UIViewController
//
//  Created by Сергей on 05/01/2021.
//  Copyright © 2021 Татьяна. All rights reserved.
//

import Foundation
import UIKit
import MapKit

enum Gender {
    case male
    case fomale
}
class User: NSObject, MKAnnotation {
  var coordinate: CLLocationCoordinate2D
  var name: String
  var city: String
  var image: UIImage
  var gender: Gender
  var title: String?{
        return name
    }
    
    init(name:String, city:String, image:UIImage, gender:Gender, coordinate:CLLocationCoordinate2D) {
        self.name = name
        self.city = city
        self.image = image
        self.gender = gender
        self.coordinate = coordinate
    }
}
