//
//  MEViewController.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit

class MEViewController: UIViewController, UINavigationControllerDelegate {
    
    


    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var favTableView: UITableView!
    @IBOutlet var orderTabelView: UITableView!
    @IBOutlet var welcomeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        orderTabelView.dataSource = self
        orderTabelView.delegate = self
        favTableView.dataSource = self
        favTableView.delegate = self
        setupNavigationBar()
        
    }
    
    @IBAction func viewMoreOrder(_ sender: UIButton) {
    }
    
    @IBAction func viewMoreFavourites(_ sender: Any) {
    }
    
    func registerCell(){
        orderTabelView.register(UINib(nibName: "OrderSettingsCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        favTableView.register(UINib(nibName: "WishListCell", bundle: nil), forCellReuseIdentifier: "WishListCell")
    }
    
    func setupNavigationBar(){
        let customOrange = UIColor(hex: 0xFF7466)
        let settingBarBtn = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(moveToSettings))
        let cartBarBtn = UIBarButtonItem(image: UIImage(systemName: "cart.fill"), style: .plain, target: self, action: #selector(moveToCart))
        settingBarBtn.tintColor = customOrange
        cartBarBtn.tintColor = customOrange
        let logOutBtn = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOut))
        logOutBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = logOutBtn
        navigationItem.rightBarButtonItems = [cartBarBtn,settingBarBtn]
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "ME"
            
    }
    @objc func moveToSettings(){
        let settingsVc = ContactViewController(nibName: "ContactViewController", bundle: nil)
        navigationController?.pushViewController(settingsVc, animated: true)
    
    }
    @objc func moveToCart(){
        let cartVC = CartViewController(nibName: "CartViewController", bundle: nil)
        navigationController?.pushViewController(cartVC, animated: true)
        
    }
    @objc func logOut(){
        
    }
}







extension MEViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == favTableView{
            return 2
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == favTableView{
            let cell = favTableView.dequeueReusableCell(withIdentifier: "WishListCell",for: indexPath) as? WishListCell
            cell?.productNameLabel.text = "bag"
            cell?.productPriceLabel.text = "9854 $"
            return cell ?? UITableViewCell()
        }else{
         let cell = orderTabelView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderSettingsCell
            cell?.orderPriceLabel.text = "555555 L.E"
            return cell ?? UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == favTableView{
            return tableView.frame.height / 2
        }
        return tableView.frame.height / 2
    }
    
}
