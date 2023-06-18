//
//  ProductViewController.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class ProductViewController: UIViewController , UISearchBarDelegate{
    
    @IBOutlet weak var searchProduct: UISearchBar!
    var isSearched : Bool?
    @IBOutlet weak var productCollection: UICollectionView!
    @IBOutlet weak var filterProduct: UISegmentedControl!
    var networkIndecator : UIActivityIndicatorView!
    var productViewModel : ProductViewModel?
    var filteredList : [Products]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        isSearched = false
        searchProduct.delegate = self
        networkIndecator = UIActivityIndicatorView(style: .large)
        networkIndecator.color =  UIColor(hex: 0xFF7466)
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
        view.addSubview(networkIndecator)
        
        productCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")
        
        productCollection.delegate = self
        productCollection.dataSource = self
        
        
         productViewModel?.getProducts(baseUrl: Constant.produts(Brand_ID: productViewModel?.brandId ?? 0))
        
        filterProduct.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        
         productViewModel?.bindproductListToProductVC = {
         DispatchQueue.main.async {
         self.productCollection.reloadData()
         self.networkIndecator.stopAnimating()
         }
    }
         
}
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearched = false
            filteredList?.removeAll()
            
        }
        else {
            isSearched = true
            filteredList?.removeAll()
            filteredList = productViewModel?.productList!.filter{products in return
                 products.title?.localizedCaseInsensitiveContains(searchText) == false
                 
            }
        }
        productCollection.reloadData()
    }
    
    
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            productViewModel?.filterProductFromLowToHigh()
        }else if sender.selectedSegmentIndex == 2 {
            productViewModel?.filterProductFromHighToLow()
        }else{
            productViewModel?.getProducts(baseUrl: Constant.produts(Brand_ID: productViewModel?.brandId ?? 0))
        }
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
        navigationItem.title = "Products"
        let CartBtn = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(goToCart))
        CartBtn.tintColor = customOrange
        let favBtn = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(goToFav))
        favBtn.tintColor = customOrange
        navigationItem.rightBarButtonItems = [CartBtn , favBtn]
    }
    @objc func goToCart(){
        let cart = CartViewController(nibName: "CartViewController", bundle: nil)
        navigationController?.pushViewController(cart, animated: true)
    }
    @objc func goToFav(){
        let fav = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
        navigationController?.pushViewController(fav, animated: true)
    }
    
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    func convertProductToCoreDataProduct(product:Products , imageDta:Data)->CoreDataProduct{
        let id  = String(product.id ?? 0)
        let title = product.title
        let url = product.image?.src
        let price = product.variants?[0].price
        var coreDataProduct = CoreDataProduct(id: id, image: imageDta, title: title ?? "", imageUrl: url ?? "", price: price ?? "", quantity: "1")
        coreDataProduct.isFavourite = true
        return coreDataProduct
    }
      /*  override func viewWillAppear(_ animated: Bool) {
            self.productViewModel?.bindedResultPrice = {
                DispatchQueue.main.async {
                    self.productCollection.reloadData()
                    self.networkIndecator.stopAnimating()
                }
            }
            setupNavigationController()
            self.productViewModel?.bindproductListToProductVC = {
                DispatchQueue.main.async {
                    self.productCollection.reloadData()
                    self.networkIndecator.stopAnimating()
                }
            }
            productViewModel?.getProducts(baseUrl: Constant.produts(Brand_ID: productViewModel?.brandId ?? 0))
        }*/
    }

    
    extension ProductViewController : UICollectionViewDelegate{
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let productDetails = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
            if isSearched == true{
                productDetails.productDetailsViewModel = productViewModel?.instantiateProductFilteredViewModel(index: indexPath.row, filterList: filteredList!)
                navigationController?.pushViewController(productDetails, animated: true)
            }else{
                productDetails.productDetailsViewModel =  productViewModel?.instantiateProductDetailsViewModel(index: indexPath.row)
                navigationController?.pushViewController(productDetails, animated: true)
            }
        }
    }


extension ProductViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched == true{
            return filteredList?.count ?? 0
        }
        return productViewModel?.getProductsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isSearched!{
            let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
            cell.productImg.sd_setImage(with: URL(string: filteredList?[indexPath.row].image?.src ?? ""))
            cell.productName.text = filteredList?[indexPath.row].title
            
            if Constant.isEuroCurrency() {
                cell.productPrice.text = filteredList?[indexPath.row].variants?[0].price
                cell.productCurrency.text = "EUR"
            }else {
                cell.productPrice.text = filteredList?[indexPath.row].variants?[0].price
                cell.productCurrency.text = "EGP"
            }
            return cell
        }
        let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let data = productViewModel?.getProductsAtIndex(index: indexPath.row)
        cell.Product = data
        if productViewModel?.isInInfav(String(data?.id ?? 0)) ?? true{
            cell.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        cell.delegate = self
        cell.productImg.sd_setImage(with: URL(string: data?.image?.src ?? ""))
        cell.productName.text = data?.title
        cell.productPrice.text = data?.variants?[0].price
        cell.productCurrency.text = "EGP"
        let img = cell.productImg.image?.jpegData(compressionQuality: 1) ?? Data()
        var favProduct = convertProductToCoreDataProduct(product: data ?? Products(), imageDta: img)
       
        
        if Constant.isEuroCurrency() {
            cell.productPrice.text = data?.variants?[0].price
            cell.productCurrency.text = "EUR"
        }else {
            cell.productPrice.text = data?.variants?[0].price
            cell.productCurrency.text = "EGP"
        }
        return cell
       
    }

}
extension ProductViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 300)
    }
}




