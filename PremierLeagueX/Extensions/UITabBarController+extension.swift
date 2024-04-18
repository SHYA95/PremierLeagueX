//
//  UITabBarController+extension.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit


/// MARK: - Create tab bar ViewController.
///
extension UITabBarController {
    func createViewController(for viewController: UIViewController,
                                      image: UIImage,
                                      title: String) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.title = title
        return viewController
    }
}
