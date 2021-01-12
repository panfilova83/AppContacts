//
//  UserTableViewCell.swift
//  UIViewController
//
//  Created by Сергей on 28/12/2020.
//  Copyright © 2020 Татьяна. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    
override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
