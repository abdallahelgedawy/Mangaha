//
//  AdressesListViewController.swift
//  Mangaha
//
//  Created by ME on 08/06/2023.
//

import UIKit

class AdressesListViewController: UIViewController {


    @IBOutlet var adressesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        adressesTable.dataSource = self
        adressesTable.delegate = self
        registerCell()
        setupNavigationBar()
    }

    func registerCell(){
        adressesTable.register(UINib(nibName: "AdressesCell", bundle: nil), forCellReuseIdentifier: "AdressesCell")
    }
    
    func setupNavigationBar(){
        let customOrange = UIColor(hex: 0xFF7466)
        navigationItem.setHidesBackButton(true, animated: true)
        let addBarBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewAdress))
        addBarBtn.tintColor = customOrange
        navigationItem.rightBarButtonItem = addBarBtn
        let backBarBtn = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.backward.fill"), style: .plain, target: self, action: #selector(BackToSettings))
        backBarBtn.tintColor = customOrange
        navigationItem.leftBarButtonItem = backBarBtn
        let apperance = UINavigationBarAppearance()
        apperance.configureWithTransparentBackground()
        apperance.backgroundColor = .white
        apperance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.standardAppearance = apperance
        navigationItem.scrollEdgeAppearance = apperance
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Your Adresses"
            
        
        
        
    }
    @objc func BackToSettings(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    @objc func addNewAdress(){
        let addAdressVC = AddingAdressViewController(nibName: "AddingAdressViewController", bundle: nil)
        navigationController?.pushViewController(addAdressVC, animated: true)
    }
  
}
extension AdressesListViewController  :UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AdressesCell", for: indexPath) as? AdressesCell
        cell?.cellBuble.changeCornerRadius(corner: [.topLeft , .bottomRight], radius: 20)
        cell?.streetLabel.text = "140 OM alsultan Street"
        cell?.cityLabel.text = "Alexandria"
        cell?.countryLabel.text = "Egypt"
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height * 0.25
    }
    
    
    
}
