//
//  ModelUser.swift
//  UIViewController
//
//  Created by Сергей on 05/01/2021.
//  Copyright © 2021 Татьяна. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ModelUser {
    var users = [[User]]()
    
    init() {
        setUp()
    }
    
    func setUp() {
    let man1 = User(name: "Сергей", city: "Москва", image: UIImage(named: "man1")!, gender: .fomale, coordinate: CLLocationCoordinate2D(latitude: 37.786834, longitude: -122.416417))
    let man2 = User(name: "Михаил", city: "Сочи", image: UIImage(named: "man2")!, gender: .fomale, coordinate: CLLocationCoordinate2D(latitude: 37.786834, longitude: -122.416617))
        
    let manArray = [man1, man2]
        
    let woman1 = User(name: "Мария", city: "Сочи", image: UIImage(named: "woman1")!, gender: .fomale, coordinate: CLLocationCoordinate2D(latitude: 37.786834, longitude: -122.416417))
    let woman2 = User(name: "Татьяна", city: "Москва", image: UIImage(named: "woman2")!, gender: .fomale, coordinate: CLLocationCoordinate2D(latitude: 37.786834, longitude: -122.416417))
        
    let womanArray = [woman1, woman2]
        
        users.append(manArray)
        users.append(womanArray)
       
    }
}
