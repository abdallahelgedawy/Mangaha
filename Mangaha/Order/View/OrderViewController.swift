//
//  OrderViewController.swift
//  Mangaha
//
//  Created by mariam adly on 19/06/2023.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var orderTableView: UITableView!
    var orderViewModel : OrderViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        orderViewModel = OrderViewModel()
        orderTableView.delegate = self
        orderTableView.dataSource = self
        
        orderTableView.register(UINib(nibName: "OrderSettingsCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "OrderCell")
        
        orderViewModel?.getOrderss(baseUrl: Constant.getOrder(customerId: Constant.getCurrentCustomerId()))

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
        navigationItem.title = "Orders"
    }
    
    @objc func popView(){
        navigationController?.popViewController(animated: true)
    }


}
extension OrderViewController : UITableViewDelegate{

}
extension OrderViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderViewModel?.getOrderssCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orderTableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderSettingsCell
        let order = orderViewModel?.getOrdersAtIndex(index: indexPath.row)
        cell.orderDateLabel.text = order?.created_at
        cell.orderPriceLabel.text = order?.line_items?[0].price
        return cell
    }
    
    
}
