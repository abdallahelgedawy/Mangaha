//
//  HomeViewController.swift
//  Mangaha
//
//  Created by mariam adly on 07/06/2023.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var brandsLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var brandSearch: UISearchBar!
    @IBOutlet weak var brandsCollection: UICollectionView!
    @IBOutlet weak var adsCollection: UICollectionView!
    var homeViewModel : HomeViewModel?
    var adsImages = [UIImage(named: "sale1"),UIImage(named: "sale2"),UIImage(named: "sale3")]
   
    var timer : Timer?
    var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel = HomeViewModel()
        brandsLabel.changeCornerRadius(corner: [.bottomLeft,.topRight], radius: 30)
        brandsLabel.layer.masksToBounds = true
        
        adsCollection.register(UINib(nibName: "AdsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "adsCell")
        brandsCollection.register(UINib(nibName: "BrandCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "brandCell")
        
        adsCollection.delegate = self
        adsCollection.dataSource = self
        
        brandsCollection.delegate = self
        brandsCollection.dataSource = self
        
        startTimer()
        
        homeViewModel?.getBrands(baseUrl: Constant.allBrands())
        homeViewModel?.bindBrandsListToHomeVC = {
            DispatchQueue.main.async {
                self.brandsCollection.reloadData()
            }
        }
        
        
        pageControl.numberOfPages = adsImages.count
       setupNavigationController()
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
        navigationItem.title = "Home"
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
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 2.4, target: self, selector: #selector(moveToNextItem), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextItem(){
        if currentIndex < adsImages.count - 1 {
           currentIndex += 1
        }else{
            currentIndex = 0
        }
        adsCollection.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }

  
}

extension HomeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == adsCollection {
           
        }else if collectionView == brandsCollection {
            let productVC = ProductViewController(nibName: "ProductViewController", bundle: nil)
            productVC.productViewModel = homeViewModel?.inistintiateProductViewModel(index: indexPath.row)
            self.navigationController?.pushViewController(productVC, animated: true)
        }
    }
    
}

extension HomeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollection {
            return adsImages.count
        }else if collectionView == brandsCollection {
            return homeViewModel?.getBrandsCount() ?? 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollection {
            let cell = adsCollection.dequeueReusableCell(withReuseIdentifier: "adsCell", for: indexPath) as! AdsCollectionViewCell
            cell.adsImg.image = adsImages[indexPath.row]
            return cell
        }
        let cell = brandsCollection.dequeueReusableCell(withReuseIdentifier: "brandCell", for: indexPath) as! BrandCollectionViewCell
        let data = homeViewModel?.getBrandsAtIndex(index: indexPath.row)
        cell.brandName.text = data?.title
        cell.brandImg.sd_setImage(with: URL(string: data?.image?.src ?? ""))

        return cell
       
    }
    
}
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollection{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        return CGSize(width: 170, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == adsCollection {
            return 0
        }
        return 10
    }
}

