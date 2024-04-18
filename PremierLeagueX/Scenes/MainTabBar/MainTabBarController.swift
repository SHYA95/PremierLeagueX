//
//  MainTabBarController.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    // MARK: - Properties
    
    private let tabbarViewControllers: [UIViewController]
    weak var coordinator: DashboardCoordinatorProtocol?
    
    // MARK: - Init
    
    init(tabbarViewControllers: [UIViewController]) {
        self.tabbarViewControllers = tabbarViewControllers
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        customizeTabBarAppearance()
    }
}


// MARK: Configuration UIViewController

extension MainTabBarController {
    private func setupViewControllers() {
        viewControllers = [
            createViewController(for: tabbarViewControllers[0], image: .tabbarHome!, title: "Home"),
            createViewController(for: tabbarViewControllers[1], image: .tabbarFav!, title: "Favourites")
        ]
    }
}


extension MainTabBarController {
    private func customizeTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 6
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.layer.shadowRadius = 8
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.2
        // Set selected item color
        tabBar.tintColor = UIColor.purple
        // Set the selected image color
        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
