//
//  LoadingManager.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit


/// Configure loading indicator.
///
final class LoadingIndicator {
    
    /// Properties.
    ///
    static let shared = LoadingIndicator()
    private(set) var isLoading: Bool = false
    
    
    /// Properties for outlets.
    ///
    private var containerView: UIView = {
        let view = UIView()
        view.frame = UIWindow(frame: UIScreen.main.bounds).frame
        view.center = UIWindow(frame: UIScreen.main.bounds).center
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        return view
    }()
    
    private var progressView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.center = UIWindow(frame: UIScreen.main.bounds).center
        view.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 0.7)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = .large
        activityIndicator.color = .white
        activityIndicator.center = CGPoint(x: progressView.bounds.width / 2, y: progressView.bounds.height / 2)
        return activityIndicator
    }()
    
    /// Usage functions.
    ///
    func showProgressView(on view: UIView) {
        isLoading = true
        progressView.addSubview(activityIndicator)
        containerView.addSubview(progressView)
        view.addSubview(containerView)
        activityIndicator.startAnimating()
    }
    
    func hideProgressView() {
        isLoading = false
        activityIndicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}



/// Configure loading manager.
///
final class LoadingManager: Support {

    /// Shared instance of loading manager.
    ///
    static var shared: LoadingManager {
        let instance = LoadingManager()
        return instance
    }
    
    
    /// Init.
    ///
    private init() { }
    
    
    /// Usage functions.
    ///
    func showLoading() {
        DispatchQueue.main.async {
            self.getTopViewController { topVC in
                if !LoadingIndicator.shared.isLoading{
                    LoadingIndicator.shared.showProgressView(on: topVC.view)
                }
            }
        }
    }
    
    func hideLoading() {
        getTopViewController { topVC in
            LoadingIndicator.shared.hideProgressView()
        }
    }
}
