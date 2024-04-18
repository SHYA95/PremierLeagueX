//
//  AppCoordinator.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit

class AppCoordinator: Coordinator {
    let navigationController: UINavigationController
    let window: UIWindow
    private var children: [Coordinator] = []
    
    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        presentDashboardCoordinator()
    }
    
    func presentDashboardCoordinator() {
        let coordinator = DashboardCoordinator(navigationController: navigationController)
        children.removeAll()
        startCoordinator(coordinator)
        replaceWindowRootViewController(coordinator.navigationController)
    }

    private func startCoordinator(_ coordinator: Coordinator) {
        children = [coordinator]
        coordinator.start()
    }

    private func replaceWindowRootViewController(_ viewController: UIViewController) {
        UIView.transition(with: window, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.window.rootViewController = viewController
            self.window.makeKeyAndVisible()
        }, completion: { _ in
            // maybe do something on completion here
        })
    }
}
