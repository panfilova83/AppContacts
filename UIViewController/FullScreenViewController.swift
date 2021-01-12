//
//  FullScreenViewController.swift
//  UIViewController
//
//  Created by Сергей on 24/12/2020.
//  Copyright © 2020 Татьяна. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
   var fotoGallere = FotoGallere()
   let identifier = "FullScreenCollectionViewCell"
   let countCells = 1
   var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "FullScreenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)

        collectionView.performBatchUpdates(nil) {(result) in
            self.collectionView.scrollToItem(at: self.indexPath, at: .centeredHorizontally, animated: false)

            self.collectionView.isPagingEnabled = true
        }
    }
}
extension FullScreenViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return fotoGallere.images.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FullScreenCollectionViewCell
     cell.photoView.image = fotoGallere.images[indexPath.item]
    return cell
}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frameCV = collectionView.frame
        let wideCell = frameCV.width / CGFloat(countCells)
        let heightCell = wideCell
        return CGSize(width: wideCell , height: heightCell)
    }
}

