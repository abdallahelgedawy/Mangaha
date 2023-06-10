//
//  ProductViewController.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var searchProduct: UISearchBar!
    
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var filterProduct: UISegmentedControl!
    
    var products = [product(name: "product1", price: 200, image: UIImage(named: "tshirt")!, cur: "EUR", inStock: "In Stock"),product(name: "product2", price: 100, image: UIImage(named: "tshirt")!, cur: "EUR", inStock: "Not In Stock"),product(name: "product3", price: 400, image: UIImage(named: "tshirt")!, cur: "EUR", inStock: "in stock"),product(name: "product4", price: 300, image: UIImage(named: "tshirt")!, cur: "EUR", inStock: "Not")]

    override func viewDidLoad() {
        super.viewDidLoad()

        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        productCollection.delegate = self
        productCollection.dataSource = self
       
    }

    @IBAction func favoriteBtn(_ sender: Any) {
    
    }
    
    @IBAction func shoppingCartBtn(_ sender: Any) {
       
    }
}

extension ProductViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ProductViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let data = products[indexPath.row]
        cell.setupCell(name: data.name, image: data.image, price: data.price, inStock: data.inStock, currency: data.cur)
        return cell
       
    }
}
extension ProductViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 200)
    }
}

struct product{
    var name : String
    var price: Int
    var image : UIImage
    var cur:String
    var inStock : String
}


