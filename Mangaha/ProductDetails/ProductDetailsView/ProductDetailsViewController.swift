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
    var price = "0.0"
    
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
        productDetailsViewModel?.bindedResultPrice = {
            self.myProductDetailsCollection.reloadData()
        }
        setupNavigationController()
        productDetailsViewModel?.getProductsInfo(baseUrl: Constant.productInfo(productId: productDetailsViewModel?.productId ?? 0))
        
        productDetailsViewModel?.bindproductInfoListToProductDetailsVC = {
            DispatchQueue.main.async {
                self.myProductDetailsCollection.reloadData()
            }
        }
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
            cell.myPage.numberOfPages = data?.src?.count ?? 0
            cell.myPage.currentPage = indexPath.item
            return cell
        case 1 :
            let cell = myProductDetailsCollection.dequeueReusableCell(withReuseIdentifier: "reviews", for: indexPath) as! ReviewsCollectionViewCell
            let data = productDetailsViewModel?.getProductAtIndex(index: indexPath.row)
            cell.nameLabel.text = data?.product.title
            if(Constant.isEuroCurrency()){
                cell.priceLabel.text = "€" + (data?.product.variants?[0].price ?? "")
            }else{
                cell.priceLabel.text = "EGP" + (data?.product.variants?[0].price ?? "")
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
        print("tapped")
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
}

    

