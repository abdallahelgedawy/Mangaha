//
//  CategoryViewController.swift
//  Mangaha
//
//  Created by mariam adly on 07/06/2023.
//

import UIKit

class CategoryViewController: UIViewController {

  
    @IBOutlet weak var searchCategory: UISearchBar!
    @IBOutlet weak var categoryCollection: UICollectionView!
    @IBOutlet weak var filterCategory: UISegmentedControl!
    
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    var categories = [category(name: "cat1", image: UIImage(named: "bag")!),category(name: "cat2", image: UIImage(named: "shoes")!),category(name: "cat3", image: UIImage(named: "tshirt")!),category(name: "cat4", image: UIImage(named: "bag")!)]
   
    private let floatingBtn : UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        let redValue: CGFloat = 255.0
        let greenValue: CGFloat = 116.0
        let blueValue: CGFloat = 102.0
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.3
        button.backgroundColor = UIColor(red: (redValue/255.0), green: (greenValue/255.0), blue: (blueValue/255.0), alpha: 1.0)
        button.setImage(UIImage(systemName: "rectangle.split.2x2.fill"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(floatingBtn)

        categoryCollection.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "categoryCell")

        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        
        floatingBtn.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
       
        button1.setImage(UIImage(named: "bag"), for: .normal)
        button1.backgroundColor = UIColor(red: (255.0/255.0), green: (116.0/255.0), blue: (102.0/255.0), alpha: 1.0)
        button1.isHidden = true
        button1.layer.cornerRadius = 30
        button1.layer.masksToBounds = true
        view.addSubview(button1)

               
        button2.setImage(UIImage(named: "shoes"), for: .normal)
        button2.backgroundColor = UIColor(red: (255.0/255.0), green: (116.0/255.0), blue: (102.0/255.0), alpha: 1.0)
        button2.isHidden = true
        button2.layer.cornerRadius = 30
        button2.layer.masksToBounds = true
        view.addSubview(button2)
        
        
        button3.setImage(UIImage(named: "tshirt"), for: .normal)
        button3.backgroundColor = UIColor(red: (255.0/255.0), green: (116.0/255.0), blue: (102.0/255.0), alpha: 1.0)
        button3.isHidden = true
        button3.layer.cornerRadius = 30
        button3.layer.masksToBounds = true
        view.addSubview(button3)
    
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingBtn.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 150, width: 60, height: 60)
        
        button1.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 220, width: 60, height: 60)

        button2.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 290, width: 60, height: 60)
        
        button3.frame = CGRect(x: view.frame.size.width - 70, y: view.frame.size.height - 360, width: 60, height: 60)
    }
    
    @objc private func didTapBtn(){
        
        button1.isHidden = !button1.isHidden
        button2.isHidden = !button2.isHidden
        button3.isHidden = !button3.isHidden
        UIView.animate(withDuration: 0.3, animations: {
                    self.view.layoutIfNeeded()
                })

    }

    @IBAction func favoriteBtn(_ sender: Any) {
        
    }
    @IBAction func shoppingCartBtn(_ sender: Any) {
        
    }
    
}

extension CategoryViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let productVC = ProductViewController(nibName: "ProductViewController", bundle: nil)
        self.navigationController?.pushViewController(productVC, animated: true)
    }
}

extension CategoryViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
        let data = categories[indexPath.row]
        cell.setupCell(name: data.name, image: data.image)
        return cell
    }
    
}

extension CategoryViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 200)
    }
}
struct category {
    var name : String
    var image : UIImage
}
