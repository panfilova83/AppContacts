//
//  ProfilViewController.swift
//  UIViewController
//
//  Created by Сергей on 14/12/2020.
//  Copyright © 2020 Татьяна. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let identifier = "PotoCollectionViewCell"
    var fotoGallere = FotoGallere()
    let countCells = 3
    let offset:CGFloat = 2.0
    let imagePicker = UIImagePickerController()
    
        
    override func viewDidLoad() {
        super.viewDidLoad()

    avatarImage.layer.borderWidth = 5.0
    avatarImage.layer.borderColor = UIColor.black.cgColor

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)

        imagePicker.delegate = self

           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnImage(_ :)))
           avatarImage.addGestureRecognizer(tapGesture)
           avatarImage.isUserInteractionEnabled = true
           
    }
    @objc func tapOnImage(_ sender:UITapGestureRecognizer){
        let alert = UIAlertController(title: "Изображение", message: nil, preferredStyle: .actionSheet)
        let actionPhoto = UIAlertAction(title: "С фотогалереи", style: .default) {(alert) in
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCamera = UIAlertAction(title: "С камеры", style: .default) {(alert) in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alert.addAction(actionPhoto)
        alert.addAction(actionCamera)
        alert.addAction(actionCancel)

        present(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let name = UserDefaults.standard.string(forKey: "nameKey"){
            nameLabel.text = name
        }
    }
}
extension ProfilViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fotoGallere.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.photoView.image = fotoGallere.images[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
             let wideCell = frameCV.width / CGFloat(countCells)
        let heightCell = wideCell
            let spacing = CGFloat((countCells + 1)) * offset / CGFloat(countCells)
        
        return CGSize(width: wideCell - spacing, height: heightCell - (offset*2))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FullScreenViewController") as! FullScreenViewController
        vc.fotoGallere = fotoGallere
        vc.indexPath = indexPath
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            avatarImage.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
