//
//  TabBar.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .white
        let redValue: CGFloat = 255.0
        let greenValue: CGFloat = 116.0
        let blueValue: CGFloat = 102.0
        UITabBar.appearance().tintColor = UIColor(red: (redValue/255.0), green: (greenValue/255.0), blue: (blueValue/255.0), alpha: 1.0)
       
        setupVCs()
    }
    

    fileprivate func createNavController(for rootViewController: UIViewController,
                                                       title: String,
                                                       image: UIImage) -> UIViewController {
             let navController = UINavigationController(rootViewController: rootViewController)
             navController.tabBarItem.title = title
             navController.tabBarItem.image = image
             navController.navigationBar.prefersLargeTitles = true
             rootViewController.navigationItem.title = title
             return navController
    }
      
    
    func setupVCs() {

        viewControllers = [createNavController(for: HomeViewController(nibName: "HomeViewController", bundle: nil), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "homekit")!),createNavController(for: CategoryViewController(nibName: "CategoryViewController", bundle: nil), title: NSLocalizedString("Category", comment: ""), image: UIImage(systemName: "rectangle.split.2x2.fill")!) , createNavController(for: MEViewController(nibName: "MEViewController", bundle: nil), title: "Profile", image: UIImage(systemName: "heart")!) ]

    }
    
}
