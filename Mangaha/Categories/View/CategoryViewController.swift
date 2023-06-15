//
//  CategoryViewController.swift
//  Mangaha
//
//  Created by mariam adly on 07/06/2023.
//

import UIKit
import SDWebImage

class CategoryViewController: UIViewController {

  
    @IBOutlet weak var searchCategory: UISearchBar!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var filterCategory: UISegmentedControl!
    var categoryViewModel : CategoryViewModel?
    var networkIndecator : UIActivityIndicatorView!
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let button4 = UIButton()
    var mainCategoryId : Int = 0
    
    var allProductsUrl = Constant.allProducts()
    private let floatingBtn : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.backgroundColor = UIColor(hex: 0xFF7466)
        button.setImage(UIImage(systemName: "rectangle.split.2x2.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryViewModel = CategoryViewModel()
        setupNavigationController()
        view.addSubview(floatingBtn)
        
        networkIndecator = UIActivityIndicatorView(style: .large)
        networkIndecator.color =  UIColor(hex: 0xFF7466)
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
        view.addSubview(networkIndecator)
        
        categoryCollection.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "productCell")

        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        filterCategory.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        categoryViewModel?.getProducts(baseUrl: allProductsUrl)
        categoryViewModel?.bindCategoryListToCategoryVC = {
            DispatchQueue.main.async {
                self.categoryCollection.reloadData()
                self.networkIndecator.stopAnimating()
            }
        }
        
        floatingBtn.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
       
        button1.setImage(UIImage(named: "bag"), for: .normal)
        button1.backgroundColor = UIColor(hex: 0xFF7466)
        button1.isHidden = true
        button1.layer.cornerRadius = 30
        button1.layer.masksToBounds = true
        view.addSubview(button1)

               
        button2.setImage(UIImage(named: "shoes"), for: .normal)
        button2.backgroundColor = UIColor(hex: 0xFF7466)
        button2.isHidden = true
        button2.layer.cornerRadius = 30
        button2.layer.masksToBounds = true
        view.addSubview(button2)
        
        
        button3.setImage(UIImage(named: "tshirt"), for: .normal)
        button3.backgroundColor = UIColor(hex: 0xFF7466)
        button3.isHidden = true
        button3.layer.cornerRadius = 30
        button3.layer.masksToBounds = true
        view.addSubview(button3)
        
        button4.setImage(UIImage(systemName: "nosign"), for: .normal)
        button4.tintColor = .white
        button4.backgroundColor = UIColor(hex: 0xFF7466)
        button4.isHidden = true
        button4.layer.cornerRadius = 30
        button4.layer.masksToBounds = true
        view.addSubview(button4)
    
        
       
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
           mainCategoryId = 448684261661
            categoryViewModel?.getProducts(baseUrl: Constant.mainCategory(category_ID: mainCategoryId ))
        }else if sender.selectedSegmentIndex == 2 {
            mainCategoryId = 448684294429
            categoryViewModel?.getProducts(baseUrl: Constant.mainCategory(category_ID: mainCategoryId ))
        }else if sender.selectedSegmentIndex == 3 {
            mainCategoryId = 448684196125
            categoryViewModel?.getProducts(baseUrl: Constant.mainCategory(category_ID: mainCategoryId ))
        }else if sender.selectedSegmentIndex == 4 {
            mainCategoryId = 448684327197
            categoryViewModel?.getProducts(baseUrl: Constant.mainCategory(category_ID: mainCategoryId ))
        }else{
            mainCategoryId = 0
            categoryViewModel?.getProducts(baseUrl: allProductsUrl)
        }
    }

    func setupNavigationController(){
        let customOrange = UIColor(hex: 0xFF7466)
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Category"
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingBtn.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 150, width: 60, height: 60)
        
        button1.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 220, width: 60, height: 60)
        button1.addTarget(self, action: #selector(filterAcc), for: .touchUpInside)

        button2.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 290, width: 60, height: 60)
        button2.addTarget(self, action: #selector(filterShoes), for: .touchUpInside)
        
        button3.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 360, width: 60, height: 60)
        button3.addTarget(self, action: #selector(filterTshirts), for: .touchUpInside)
        
        button4.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 430, width: 60, height: 60)
        button4.addTarget(self, action: #selector(noFilter), for: .touchUpInside)
    }
    
    @objc private func noFilter(){
        if mainCategoryId == 0 {
            categoryViewModel?.getProducts(baseUrl: Constant.allProducts())
        }else{
            categoryViewModel?.getProducts(baseUrl:  Constant.mainCategory(category_ID: mainCategoryId))
        }
    }
    
    @objc private func filterAcc(){
        if mainCategoryId == 0 {
           allProductsUrl = allProductsUrl + "&product_type=ACCESSORIES"
            categoryViewModel?.getProducts(baseUrl: allProductsUrl)
        }else{
            categoryViewModel?.getProducts(baseUrl:  Constant.mainCategory(category_ID: mainCategoryId , filterType: "ACCESSORIES"))
        }
    }
    
    @objc private func filterShoes(){
        if mainCategoryId == 0 {
           allProductsUrl = allProductsUrl + "&product_type=SHOES"
            categoryViewModel?.getProducts(baseUrl: allProductsUrl)
        }else{
            categoryViewModel?.getProducts(baseUrl: Constant.mainCategory(category_ID: mainCategoryId , filterType: "SHOES"))
        }
    }
    
    @objc private func filterTshirts(){
        if mainCategoryId == 0 {
           allProductsUrl = allProductsUrl + "&product_type=T-SHIRTS"
            categoryViewModel?.getProducts(baseUrl: allProductsUrl)
        }else{
            categoryViewModel?.getProducts(baseUrl:Constant.mainCategory(category_ID: mainCategoryId , filterType: "T-SHIRTS"))
        }
    }
    
    @objc private func didTapBtn(){
        
        button1.isHidden = !button1.isHidden
        button2.isHidden = !button2.isHidden
        button3.isHidden = !button3.isHidden
        button4.isHidden = !button4.isHidden
        UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })

    }

}

extension CategoryViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var productDetails = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        productDetails.productDetailsViewModel = categoryViewModel?.instantiateProductDetailsViewModel(index: indexPath.row)
        navigationController?.pushViewController(productDetails, animated: true)
    }
}

extension CategoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var list = categoryViewModel?.getProductsCount() ?? 0
        if list == 0 {
            categoryCollection.isHidden = true
        }else{
            categoryCollection.isHidden = false
        }
        return list
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        let data = categoryViewModel?.getProductsAtIndex(index: indexPath.row)
        cell.productImg.sd_setImage(with: URL(string: data?.image?.src ?? ""))
        cell.productName.text = data?.title
       // var currency = categoryViewModel?.getCurrency(amount: data?.variants?[0].price ?? "")
        cell.productPrice.text = data?.variants?[0].price
        print(UserDefaults.standard.object(forKey: Constant.currencyKey))
        if Constant.isEuroCurrency(){
            cell.productCurrency.text = "€"
        }
        cell.productCurrency.text = "EGP"
        return cell
    }
    
}

extension CategoryViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 300)
        
    }
}

