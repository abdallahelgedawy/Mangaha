//
//  PaymentDoneViewController.swift
//  Mangaha
//
//  Created by ME on 20/06/2023.
//

import UIKit

class PaymentDoneViewController: UIViewController {

    @IBOutlet var PhoneLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var backHomeBtn: UIButton!
    @IBOutlet var deliveryInfoView: UIView!
    @IBOutlet var productTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        productTable.dataSource = self
        productTable.delegate = self
        RegisterCell()
    }

    func RegisterCell(){
        productTable.register(UINib(nibName: "FinalOrderCell", bundle: nil), forCellReuseIdentifier: "FinalOrderCell")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func BackToHome(_ sender: UIButton) {
    }
}

extension PaymentDoneViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
