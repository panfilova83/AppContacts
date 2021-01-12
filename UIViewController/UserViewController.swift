//
//  UserViewController.swift
//  UIViewController
//
//  Created by Сергей on 05/01/2021.
//  Copyright © 2021 Татьяна. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user.name
        cityLabel.text = user.city
        imageView.image = user.image

        imageView.layer.borderWidth = 3.0
        imageView.layer.cornerRadius = 40

        if user.gender == .male{
            imageView.layer.borderColor = UIColor.blue.cgColor
        } else {
            imageView.layer.borderColor = UIColor.red.cgColor
        }
    }
}
