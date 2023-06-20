//
//  ProductDetailsViewController.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 08/06/2023.
//

import UIKit

class ProductDetailsViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate {
    
    
    
    var productDetailsViewModel : ProductDetailsViewModel?
    @IBOutlet weak var favBtn: UIButton!
    
    @IBOutlet weak var bagBtn: UIButton!
    var image:UIImage?
   
    var guest = UserDefaults.standard.object(forKey: "isGuest") as? Bool
    var price = "0.0"
    var networkIndecator : UIActivityIndicatorView!
    @IBOutlet weak var myProductDetailsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*   productDetailsViewModel?.bindedResultPrice = {
         self.myProductDetailsCollection.reloadData()
         }
         setupNavigationController()
         productDetailsViewModel?.getProductsInfo(baseUrl: Constant.productInfo(productId: productDetailsViewModel?.productId ?? 0))
         
         productDetailsViewModel?.bindproductInfoListToProductDetailsVC = {
         DispatchQueue.main.async {
         self.myProductDetailsCollection.reloadData()
         }
         }*/
        networkIndecator = UIActivityIndicatorView(style: .large)
        networkIndecator.color =  UIColor(hex: 0xFF7466)
        networkIndecator.center = view.center
        networkIndecator.startAnimating()
        view.addSubview(networkIndecator)
        favBtn.layer.cornerRadius = 20
        bagBtn.layer.cornerRadius = 20
        let nib = UINib(nibName: "ProductDetailsCollectionViewCell", bundle: nil)
        myProductDetailsCollection.register(nib, forCellWithReuseIdentifier: "productDetails")
        myProductDetailsCollection.register(UINib(nibName: "ReviewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "reviews")
        myProductDetailsCollection.register(UINib(nibName: "DescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "description")
        myProductDetailsCollection.dataSource = self
        myProductDetailsCollection.delegate = self
        myProductDetailsCollection.isPagingEnabled = true
        let layout = UICollectionViewCompositionalLayout {
            index , environment in
            switch index {
            case 0 :
                return self.drawTopSection()
            case 1 :
                return self.drawCenterSection()
            case 2 :
                return self.drawBottomSection()
            default:
                return nil
            }
            
        }
        myProductDetailsCollection.setCollectionViewLayout(layout, animated: true)
        myProductDetailsCollection.contentInsetAdjustmentBehavior = .never
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func drawBottomSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom:0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        // Set the section footer
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(400))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        section.boundarySupplementaryItems = [header, footer]
        
        return section
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
     
        self.productDetailsViewModel?.bindedResultPrice = {
            DispatchQueue.main.async {
                self.myProductDetailsCollection.reloadData()
              //  self.networkIndecator.stopAnimating()
            }
            
        }
      
      
        
        setupNavigationController()
            self.productDetailsViewModel?.bindproductInfoListToProductDetailsVC = {
                DispatchQueue.main.async {
                    self.networkIndecator.stopAnimating()
                    self.myProductDetailsCollection.reloadData()
                }
            }
            
        
        productDetailsViewModel?.getProductsInfo(baseUrl: Constant.productInfo(productId: productDetailsViewModel?.productId ?? 0))
    }

      
    
    
    
    func drawTopSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "header", alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    func drawCenterSection()->NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: -70, leading: 0, bottom: 0, trailing: 0)
        section.accessibilityScroll(UIAccessibilityScrollDirection.down)
        return section
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return productDetailsViewModel?.getImagesCount() ?? 0
        case 1 :
            return 1
        case 2 :
            return 1
        default:
            return 0
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
        navigationItem.title = "Product Details"
    }
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        switch indexPath.section{
        case 0 :
            let cell = myProductDetailsCollection.dequeueReusableCell(withReuseIdentifier: "productDetails", for: indexPath) as! ProductDetailsCollectionViewCell
            let data = productDetailsViewModel?.getImagesAtIndex(index: indexPath.row)
            cell.imageProductDetails.layer.cornerRadius = 10
            cell.imageProductDetails.sd_setImage(with: URL(string: data?.src ?? ""))
            let hexColor = UIColor(hex: 0xFF7466)
            cell.myPage.currentPageIndicatorTintColor = hexColor
            cell.myPage.numberOfPages = data?.position ?? 0
            cell.myPage.currentPage = indexPath.item
            image = cell.imageProductDetails.image
            return cell
        case 1 :
            let cell = myProductDetailsCollection.dequeueReusableCell(withReuseIdentifier: "reviews", for: indexPath) as! ReviewsCollectionViewCell
            let data = productDetailsViewModel?.getProductAtIndex(index: indexPath.row)
                    
            cell.nameLabel.text = data?.product.title
            if(Constant.isEuroCurrency()){
                cell.priceLabel.text =  (data?.product.variants?[0].price ?? "")  + "EUR"
            }else{
                cell.priceLabel.text = (data?.product.variants?[0].price ?? "") + "EGP"
            }
            if productDetailsViewModel?.isInFavourite(data?.product.id ?? 0) ?? false{
                favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            cell.btn.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            cell.btn.isUserInteractionEnabled = true
            return cell
        case 2 :
            let cell = myProductDetailsCollection.dequeueReusableCell(withReuseIdentifier: "description", for: indexPath) as! DescriptionCollectionViewCell
            let data = productDetailsViewModel?.getProductAtIndex(index: indexPath.row)
            cell.descriptionLabel.text = data?.product.body_html
            return cell
        default :
            return UICollectionViewCell()
        }
       
    }
    
    
    
    @objc func buttonTapped(_ sender: UIButton) {
        let moreReviews = MoreReviewsTableViewController(nibName: "MoreReviewsTableViewController", bundle: nil)
        navigationController?.pushViewController(moreReviews, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            // Adjust the size for the "productDetails" cell
            return CGSize(width: myProductDetailsCollection.bounds.width, height: 300)
        case 1:
            // Adjust the size for the "reviews" cell
            return CGSize(width: myProductDetailsCollection.bounds.width, height: 200)
        default:
            return CGSize.zero
        }
    }
    
    @IBAction func addToFavourite(_ sender: UIButton) {
        if guest == true{
        let alertController = UIAlertController(title: "Alert", message: "Cannot Use This Feature", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Back To Sign in", style: .default) { (_) in
            let signInVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(signInVc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            self.tabBarController?.hidesBottomBarWhenPushed = true
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        }else {
            setupFavouriteProduct()
        }
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        if guest == true{
        let alertController = UIAlertController(title: "Alert", message: "Cannot Use This Feature", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Back To Sign in", style: .default) { (_) in
            let signInVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            self.navigationController?.pushViewController(signInVc, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            self.tabBarController?.hidesBottomBarWhenPushed = true
        }
        
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        }else {
            setupCartProduct()
        }
    }
    
    func setupCartProduct(){
        let product = productDetailsViewModel?.getProductAtIndex(index: 0)?.product
        if ((productDetailsViewModel?.isInCart(product?.id ?? 0))) ?? false {
            self.view.makeToast("This product is already in cart")
        }else{
            let id = String(product?.id ?? 0)
            let title = product?.title
            let url = product?.image?.src
            let imageData = image?.jpegData(compressionQuality: 1)
            let price = product?.variants?[0].price
            let SavedProduct = CoreDataProduct(id: id, image: imageData ?? Data(), title: title ?? "", imageUrl: url ?? "", price: price ?? "", quantity: "1")
            productDetailsViewModel?.addProductToCart(product: SavedProduct)
            self.view.makeToast("Product added to cart")
        }
    }
    func setupFavouriteProduct(){
        let product = productDetailsViewModel?.getProductAtIndex(index: 0)?.product
        if ((productDetailsViewModel?.isInFavourite(product?.id ?? 0))) ?? false {
            deletingFromFavouritesAlert(String(product?.id ?? 0))
        }else{
            let id = String(product?.id ?? 0)
            let title = product?.title
            let url = product?.image?.src
            let imageData = image?.jpegData(compressionQuality: 1)
            let price = product?.variants?[0].price
            var SavedProduct = CoreDataProduct(id: id, image: imageData ?? Data(), title: title ?? "", imageUrl: url ?? "", price: price ?? "", quantity: "1")
            SavedProduct.isFavourite = true
            productDetailsViewModel?.addProductToCart(product: SavedProduct)
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.view.makeToast("Product added to Favourites")
        }
    }
    
    func deletingFromFavouritesAlert(_ id:String){
        let deletingAddress = UIAlertController(title: "Delete From Favourites", message: "Are you sure you want to delete this product from Fvourites ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .destructive){_ in
            self.productDetailsViewModel?.deleteProductFromFavourites(id, true)
            self.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            self.myProductDetailsCollection.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        self.present(deletingAddress, animated: true)
    }
    
}


    
    
    

    

