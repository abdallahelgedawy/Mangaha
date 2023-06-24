//
//  CartViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class CartViewController: UIViewController , cartViewDelegate{
   
    

    @IBOutlet var noproductLabel: UILabel!
    @IBOutlet var subTot: UILabel!
    @IBOutlet var nodataImg: UIImageView!
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
        if  cartVM.getProductsCount() == 0{
            nodataImg.isHidden = false
            noproductLabel.isHidden = false
            checkOutBtn.isHidden = true
            subTotalLabel.isHidden = true
            subTot.isHidden = true
        }else{
            nodataImg.isHidden = true
            noproductLabel.isHidden = true
            checkOutBtn.isHidden = false
            subTotalLabel.isHidden = false
            subTot.isHidden = false
        }
    
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
            if self.cartVM.getProductsCount() == 0{
                self.nodataImg.isHidden = false
                self.noproductLabel.isHidden = false
                self.subTot.isHidden = true
                self.checkOutBtn.isHidden = true
                self.subTotalLabel.isHidden = true
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        self.present(deletingAddress, animated: true)
    }
    func updateCartTable() {
        cartTable.reloadData()
    }

}
extension CartViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cartVM.getProductsCount() == 0 {
            nodataImg.isHidden = false
            noproductLabel.isHidden = false
        }else{
            nodataImg.isHidden = true
            noproductLabel.isHidden = true
            checkOutBtn.isHidden = false
            subTotalLabel.isHidden = false
            subTot.isHidden = false
        }
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartCell
        let product = cartVM.getProductAtIndex(index: indexPath.row)
        cell?.productName.text = product.title
        cell?.productCount.text = product.quantity
        let price : Double = (Double(product.price ?? "0.0") ?? 0.0) * 34.0
        if Constant.isEuroCurrency(){
            cell?.productPrice.text = (product.price ?? "0.0") + "  EUR"
        }else{
            cell?.productPrice.text = String(price) + "   EGP"
        }
        cell?.productImg.sd_setImage(with: URL(string: product.imageUrl ?? ""), placeholderImage: UIImage(named: "data"))
        cell?.productId = product.id
        subTotalLabel.text = cartVM.getCartSubTotal()
        cell?.cartDelegate = self
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productDetVC = ProductDetailsViewController(nibName: "ProductDetailsViewController", bundle: nil)
        productDetVC.productDetailsViewModel = cartVM.inistintiateProductDetVM(indexPath.row)
        navigationController?.pushViewController(productDetVC, animated: true)
    }
    
}


