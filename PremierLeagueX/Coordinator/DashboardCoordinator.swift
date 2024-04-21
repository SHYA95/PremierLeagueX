//
//  DashboardCoordinator.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit

protocol DashboardCoordinatorProtocol: AnyObject {
    func showDashboard()
    func presentErrorAlert(errorType: AppErrorType)
}

class DashboardCoordinator: Coordinator {
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showDashboard()
    }
}

extension DashboardCoordinator: DashboardCoordinatorProtocol {
    func showDashboard() {
        let viewControllers = [getHomeViewController(), getFavViewController()]
        let mainTabBar = MainTabBarController(tabbarViewControllers: viewControllers)
        mainTabBar.coordinator = self
        show(viewController: mainTabBar)
    }
   
    
    func presentErrorAlert(errorType: AppErrorType) {
        let alertController = UIAlertController(title: "Error", message: errorType.message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController.present(alertController, animated: true, completion: nil)
    }
}

extension DashboardCoordinator {
    func getHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
//        viewController.coordinator = self
        return viewController
    }
    
    func getFavViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        let viewController = FavouriteViewController(viewModel: viewModel)
//        viewController.coordinator = self
        return viewController
    }
}

