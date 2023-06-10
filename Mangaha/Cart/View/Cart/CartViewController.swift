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
    override func viewDidLoad() {
        super.viewDidLoad()
        cartTable.dataSource = self
        cartTable.delegate = self
        registerCell()
        checkOutBtn.layer.cornerRadius = 20
        checkOutBtn.clipsToBounds = true
        setupNavigationController()
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

}
extension CartViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartCell
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        cartTable.frame.height * 0.3
    }
    
}
