//
//  FotoGallere.swift
//  UIViewController
//
//  Created by Сергей on 22/12/2020.
//  Copyright © 2020 Татьяна. All rights reserved.
//

import Foundation
import UIKit

class FotoGallere{
    var images = [UIImage]()

   init (){
        setUpGallere()
    }

    func setUpGallere (){
        for i in 0...5{
            let image = UIImage(named: "image\(i)")!
                   images.append(image)
        }
    }
}
