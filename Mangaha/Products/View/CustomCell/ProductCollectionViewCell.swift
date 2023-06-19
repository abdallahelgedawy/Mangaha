//
//  ProductCollectionViewCell.swift
//  Mangaha
//
//  Created by mariam adly on 08/06/2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    let productViewModel = ProductViewModel()
    @IBOutlet weak var productView: UIView!
    @IBOutlet weak var productName: UILabel!
    var delegate : ProductViewController? = nil
    var categoryDelegate : CategoryViewController?
    @IBOutlet weak var productImg: UIImageView!
    var Product:Products?
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet var favBtn: UIButton!
    var guest = UserDefaults.standard.object(forKey: "isGuest") as? Bool
    @IBOutlet weak var productCurrency: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        productView.layer.shadowOpacity = 0.3
        productView.layer.shadowRadius = 10
    }

    @IBAction func favoriteBtn(_ sender: Any) {if guest == true{
        let alertController = UIAlertController(title: "Alert", message: "Cannot Use This Feature", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Back To Sign in", style: .default) { (_) in
            guard let viewController = self.superview?.next(ofType: UIViewController.self) as? UIViewController else {
                return
            }
            

            let signInVc = LoginViewController(nibName: "LoginViewController", bundle: nil)
            viewController.navigationController?.pushViewController(signInVc, animated: true)
            viewController.tabBarController?.tabBar.isHidden = true
            viewController.tabBarController?.hidesBottomBarWhenPushed = true

        }

        let cancelAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            // Present the alert on the topmost view controller
            topViewController.present(alertController, animated: true, completion: nil)
        }
    }else {
        if let Product = Product{
            handleFavouriteProduct(product: Product)
        }
    }
}
    
func handleFavouriteProduct(product: Products) {
    if ((productViewModel.isInInfav(String(product.id ?? 0)))) {
            deletingFromFavouritesAlert(String(product.id ?? 0))
        }else{
            let id = String(product.id ?? 0)
            let title = product.title
            let url = product.image?.src
            let imageData = productImg.image?.jpegData(compressionQuality: 1)
            let price = product.variants?[0].price
            var SavedProduct = CoreDataProduct(id: id, image: imageData ?? Data(), title: title ?? "", imageUrl: url ?? "", price: price ?? "", quantity: "1")
            SavedProduct.isFavourite = true
            productViewModel.addProductToFavourites(product: SavedProduct)
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if let delegate = delegate {
                delegate.view.makeToast("Product added to Favourites")
            }else{
                categoryDelegate?.view.makeToast("Product added to Favourites")
            }
        }
    }
    
    func deletingFromFavouritesAlert(_ id:String){
        let deletingAddress = UIAlertController(title: "Delete From Favourites", message: "Are you sure you want to delete this product from Fvourites ?", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Delete", style: .destructive){_ in
            self.productViewModel.deleteProductFromFavourite(id)
            self.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){_ in
            deletingAddress.dismiss(animated: true)
        }
        deletingAddress.addAction(confirm)
        deletingAddress.addAction(cancel)
        if let delegate = delegate{
            delegate.present(deletingAddress, animated: true)
        }else{
            categoryDelegate?.present(deletingAddress, animated: true)
        }
    }
}
extension UIResponder {
    func next<T>(ofType type: T.Type) -> T? {
        if let nextResponder = self.next as? T {
            return nextResponder
        } else if let nextResponder = self.next {
            return nextResponder.next(ofType: type)
        } else {
            return nil
        }
    }
}






