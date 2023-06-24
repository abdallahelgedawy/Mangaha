//
//  NetworkConnection.swift
//  Mangaha
//
//  Created by Abdallah Elgedawy on 23/06/2023.
//

import Foundation
import Reachability
import Lottie

class ReachabilityManager {
    static let shared = ReachabilityManager()
    let animationView = LottieAnimationView()
    
    private let reachability = try? Reachability()
    
    private init() {
        startListening()
    }
    func setupAnimation(){
                
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
            if let alertView = UIApplication.shared.windows.first?.rootViewController?.view.viewWithTag(1234) {
                       alertView.removeFromSuperview()
                   }
            
        }else{
            print("no Internet")
            let alertView = UIView(frame: UIScreen.main.bounds)
            alertView.tag = 1234
            alertView.backgroundColor = .black
            animationView.animation = LottieAnimation.named("network")
            animationView.contentMode = .scaleToFill
            let animationScale: CGFloat = 1.5 // Adjust the scale factor as needed
            animationView.transform = CGAffineTransform(scaleX: animationScale, y: animationScale)
            animationView.loopMode = .loop
            animationView.play()
            animationView.translatesAutoresizingMaskIntoConstraints = false
            // Center the animation view horizontally
            alertView.addSubview(animationView)
            NSLayoutConstraint.activate([
                animationView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor)
            ])

            if let topViewController = UIApplication.shared.windows.first?.rootViewController {
                topViewController.view.addSubview(alertView)
            }
        }
    }

    
    
    deinit {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
