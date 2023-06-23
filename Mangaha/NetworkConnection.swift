//
//  NetworkConnection.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 23/06/2023.
//

import Foundation
import Reachability

class ReachabilityManager {
    static let shared = ReachabilityManager()
    
    private let reachability = try? Reachability()
    
    private init() {
        startListening()
    }
    
    private func startListening() {
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Failed to start reachability notifier: \(error)")
        }
    }
    
    @objc private func networkStatusChanged(_ notification: Notification) {
        guard let reachability = notification.object as? Reachability else {
            return
        }
        
        if reachability.connection != .unavailable {
            // Handle network unavailable
            print("there is internet connection")
            
        } else {
            let alertController = UIAlertController(title: "Internet Connection", message: "Check Your Internet Connection!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            }
            
            alertController.addAction(okAction)
            if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
                topViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
