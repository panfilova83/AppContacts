//
//  FriendsViewController.swift
//  UIViewController
//
//  Created by Сергей on 28/12/2020.
//  Copyright © 2020 Татьяна. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cellID = "UserTableViewCell"
    var modelUser = ModelUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
      
    }
    
}
extension FriendsViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = modelUser.users[section]

        return section.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return modelUser.users.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Мужчины"
        }
        else {
            return "Женщины"
    }
}

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! UserTableViewCell
    let section = modelUser.users[indexPath.section]
        
    let user = section[indexPath.row]
    cell.nameLabel.text = user.name
    cell.userImageView.image = user.image
          return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    let section = modelUser.users[indexPath.section]
    let user = section[indexPath.row]
    let alert = UIAlertController(title: user.name, message: user.city, preferredStyle: .alert)
    let profilAction = UIAlertAction(title: "Профиль", style: .default) { (alert) in

    self.performSegue(withIdentifier: "goToProfile", sender: indexPath)
        }
        let deletAction = UIAlertAction(title: "Удалить из друзей", style: .default) { (alert) in
            self.modelUser.users[indexPath.section].remove(at: indexPath.row)
            tableView.reloadData()
        }
    alert.addAction(profilAction)
    alert.addAction(deletAction)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile"{
    let VC = segue.destination as! UserViewController
    let indexPath = sender as! IndexPath
    let section = modelUser.users[indexPath.section]
    let user = section[indexPath.row]
            
    VC.user = user
        }
    }
}
