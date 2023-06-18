//
//  OnboardingViewController.swift
//  Mangaha
//
//  Created by mariam adly on 15/06/2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var onboardingCollection: UICollectionView!
    
    var slides = [OnboardingSlide]()
    var currentPage = 0{
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1{
                nextBtn.setTitle("Get Started", for: .normal)
            }else{
                nextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 10
        onboardingCollection.delegate = self
        onboardingCollection.dataSource = self
        
        
        onboardingCollection.register(UINib(nibName: "OnboardingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "onboardingCell")
        
        slides = [OnboardingSlide(title: "Add To Cart", description: "Our new service makes it easy for you to work anywhere. there are new features will really help you.", image: UIImage(named: "on1")!),OnboardingSlide(title:"Confirm Order", description: "Our new service makes it easy for you to work anywhere. there are new features will really help you.", image:UIImage(named:"on2")! ),OnboardingSlide(title: "Make Payment", description: "Our new service makes it easy for you to work anywhere. there are new features will really help you.", image:UIImage(named:"on3")! )]
    }

    @IBAction func nextBtnAction(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            let HomeVC = TabBar()
            HomeVC.modalPresentationStyle = .fullScreen
            HomeVC.modalTransitionStyle = .flipHorizontal
            present(HomeVC, animated: true,completion: nil)
            
        }else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            onboardingCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}
extension OnboardingViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "onboardingCell", for: indexPath) as! OnboardingCollectionViewCell
        let sliders = slides[indexPath.row]
        cell.setCell(title: sliders.title, description: sliders.description, photo: sliders.image)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
}
