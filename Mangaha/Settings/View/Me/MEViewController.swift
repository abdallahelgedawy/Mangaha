//
//  MEViewController.swift
//  Mangaha
//
//  Created by ME on 07/06/2023.
//

import UIKit
import FirebaseAuth

class MEViewController: UIViewController, UINavigationControllerDelegate {
    
    
    
    let profileVM = ProfileViewModel()
    @IBOutlet var navigationBar: UINavigationBar!
    @IBOutlet var favTableView: UITableView!
    @IBOutlet var orderTabelView: UITableView!
    @IBOutlet var welcomeLabel: UILabel!
    var guest = UserDefaults.standard.object(forKey: "isGuest") as? Bool
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        orderTabelView.dataSource = self
        orderTabelView.delegate = self
        favTableView.dataSource = self
        favTableView.delegate = self
        setupNavigationBar()
       // profileVM.getWishList()
        profileVM.getOrderss(baseUrl: Constant.getOrder(customerId: Int(Constant.getCurrentCustomerId()) ?? 0))
        profileVM.bindOrderListToMEVC = {
            DispatchQueue.main.async {
                self.orderTabelView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("will appear")
        profileVM.getWishList()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        print("did appear")
        profileVM.getWishList()
        favTableView.reloadData()
    }
    
    @IBAction func viewMoreOrder(_ sender: UIButton) {
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
            let orderVC = OrderViewController(nibName: "OrderViewController", bundle: nil)
            navigationController?.pushViewController(orderVC, animated: true)
        }
    }
    
    @IBAction func viewMoreFavourites(_ sender: Any) {
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
            let favVC = FavoriteViewController(nibName: "FavoriteViewController", bundle: nil)
            navigationController?.pushViewController(favVC, animated: true)
        }
    }
    
    func registerCell(){
        orderTabelView.register(UINib(nibName: "OrderSettingsCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
        favTableView.register(UINib(nibName: "WishListCell", bundle: nil), forCellReuseIdentifier: "WishListCell")
    }
    
    func setupNavigationBar(){
        navigationController?.setNavigationBarHidden(false, animated: true)
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
            let settingsVc = ContactViewController(nibName: "ContactViewController", bundle: nil)
            navigationController?.pushViewController(settingsVc, animated: true)
        }
    }
    @objc func moveToCart(){
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
            let cartVC = CartViewController(nibName: "CartViewController", bundle: nil)
            navigationController?.pushViewController(cartVC, animated: true)
        }
    }
    @objc func logOut(){
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
            self.tabBarController?.tabBar.isHidden = true
            self.tabBarController?.hidesBottomBarWhenPushed = true
            self.profileVM.bindedResult = {
                let loginVC  = LoginViewController(nibName: "LoginViewController", bundle: nil)
                self.navigationController?.pushViewController(loginVC, animated: true)
                
            }
            self.profileVM.makeFavouritesDraftOrder()
        }
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.hidesBottomBarWhenPushed = true
                self.profileVM.bindedResult = {
                    self.profileVM.resetUserDefualtsCoupons()
                    let loginVC  = LoginViewController(nibName: "LoginViewController", bundle: nil)
                    self.navigationController?.pushViewController(loginVC, animated: true)
                    
                }
                self.profileVM.makeFavouritesDraftOrder()
    }
}







extension MEViewController : UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == favTableView{
            if profileVM.getFavouritesCount() <= 2 {
                return profileVM.getFavouritesCount()
            }else{
                return 2
            }
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == favTableView{
            let cell = favTableView.dequeueReusableCell(withIdentifier: "WishListCell",for: indexPath) as? WishListCell
            let favProduct = profileVM.getFavByIndex(indexPath.row)
            cell?.productNameLabel.text = favProduct.title
            if Constant.isEuroCurrency() == false{
                cell?.productPriceLabel.text = (favProduct.price ?? "") + "   EGP"
            }else{
                cell?.productPriceLabel.text =  (favProduct.price ?? "") + "   EUR"
            }
            cell?.productImg.image = UIImage(data: favProduct.image ?? Data())
            return cell ?? UITableViewCell()
        }else{
         let cell = orderTabelView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderSettingsCell
            let order = profileVM.getOrdersAtIndex(index: indexPath.row)
            cell?.orderPriceLabel.text = order.line_items?[0].price
            cell?.orderDateLabel.text = order.created_at
            return cell ?? UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == favTableView{
            return tableView.frame.height / 2
        }
        return tableView.frame.height / 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let prodctDetVC = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        prodctDetVC.productDetailsViewModel = profileVM.inistintiateProductDetVM(indexPath.row)
        navigationController?.pushViewController(prodctDetVC, animated: true)
    }
    
}
