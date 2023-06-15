//
//  CartViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet var checkOutBtn: UIButton!
    @IBOutlet var subTotalLabel: UILabel!
    @IBOutlet var cartTable: UITableView!
    let cartVM = CartViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTable.dataSource = self
        cartTable.delegate = self
        registerCell()
        checkOutBtn.layer.cornerRadius = 20
        checkOutBtn.clipsToBounds = true
        setupNavigationController()
    }
    override func viewWillAppear(_ animated: Bool) {
        cartVM.getCartProducts()
    }

    func registerCell(){
        cartTable.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "cartCell")
    }

    @IBAction func checkOut(_ sender: UIButton) {
        let deliveryInfoVC = DeliveryInfoViewController(nibName: "DeliveryInfoViewController", bundle: nil)
        navigationController?.pushViewController(deliveryInfoVC, animated: true)
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
        navigationItem.title = "Cart"
    }
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }
    
    func deletingFromCartAlert(_ id:String , _ index:Int){
        let deletingAddress = UIAlertController(title: "Delete From Cart", message: "Are you sure you want to delete this product from cart ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .destructive){_ in
            self.cartVM.deleteFromCart(id ,index)
            self.cartTable.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        self.present(deletingAddress, animated: true)
    }

}
extension CartViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartCell
        let product = cartVM.getProductAtIndex(index: indexPath.row)
        cell?.productName.text = product.title
        cell?.productCount.text = product.quantity
        cell?.productPrice.text = product.price
        if let image = product.image{
            cell?.productImg.image = UIImage(data: image)
        }else{
            cell?.productImg.image = UIImage(named: "data")
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartVM.getProductsCount()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cartTable.frame.height * 0.3
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let product = cartVM.getProductAtIndex(index: indexPath.row)
            deletingFromCartAlert(product.id ?? "0" , indexPath.row)
        }
    }
    
}
