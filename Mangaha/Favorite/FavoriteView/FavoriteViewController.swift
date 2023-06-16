//
//  FavoriteViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 07/06/2023.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
   
    @IBOutlet weak var myFavCollection: UICollectionView!
    let favouriteVM = FavoriteViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        let nib = UINib(nibName: "FavoriteCollectionViewCell", bundle: nil)
        myFavCollection.register(nib, forCellWithReuseIdentifier: "favCell")
        myFavCollection.dataSource = self
        myFavCollection.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        favouriteVM.getFavouritProducts()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favouriteVM.getFavouritesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myFavCollection.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! FavoriteCollectionViewCell
        let favProduct = favouriteVM.getProductByIndex(indexPath.row)
        cell.favImage.layer.cornerRadius = 10.0
        cell.favImage.clipsToBounds = true
        cell.favImage.image = UIImage(data: favProduct.image ?? Data())
        if Constant.isEuroCurrency(){
            cell.productPrice.text = (favProduct.price ?? "0.0") + "    EUR"
        }else{
            cell.productPrice.text = (favProduct.price ?? "0.0") + "    EGP"
        }
        cell.productTitle.text = favProduct.title
        
        
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
    func setupNavigationController(){
        navigationItem.setHidesBackButton(true, animated: true)
        let customOrange = UIColor(hex: 0xFF7466)
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(popView))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
       
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Favorites"
    }
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }
    func deletingFromFavouritesAlert(_ id:String , _ index:Int){
        let deletingAddress = UIAlertController(title: "Delete From Favourites", message: "Are you sure you want to delete this product from Fvourites ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .destructive){_ in
            self.favouriteVM.deleteFromFavourites(id, isFav: true, index)
            self.myFavCollection.reloadData()
            if self.favouriteVM.getFavouritesCount() == 0{
             
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        self.present(deletingAddress, animated: true)
    }

    
    
   
  }

    


