//
//  FavoriteViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var myFavCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
        myFavCollection.register(nib, forCellWithReuseIdentifier: "favCell")
        myFavCollection.dataSource = self
        myFavCollection.delegate = self
       
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myFavCollection.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.favImage.layer.cornerRadius = 10.0
        cell.favImage.clipsToBounds = true
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = myFavCollection.bounds.width * 0.46
        let cellHeight = myFavCollection.bounds.height * 0.5
        return CGSize(width: availableWidth, height: cellHeight)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myFavCollection.collectionViewLayout.invalidateLayout()
    }
    
    
   
  }

    


