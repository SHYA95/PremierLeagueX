//
//  Coordinator.swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 18/04/2024.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get }
    func start()
}

extension Coordinator {
    func show(viewController: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(viewController, animated: animated)
    }
        
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func presentViewController(viewController: UIViewController, animated: Bool = true) {
        navigationController.present(viewController, animated: animated)
    }
    
    func presentCoordinator(coordinator: Coordinator, animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.present(coordinator.navigationController, animated: animated, completion: completion)
    }
    
    func dismiss(animated: Bool = true, completion: @escaping () -> Void = {}) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
//    func presentBottomList(type: BottomListSheetType, delegate: UIViewController) {
//        let viewModel = BottomListSheetViewModel(type: type)
//        let viewController = BottomListSheet(viewModel: viewModel)
//        viewController.delegate = delegate as? BottomListSheetDismissProtocol
//        navigationController.present(viewController, animated: true)
//    }
    
//    func presentErrorAlertViewController(errorType: AppErrorType) {
//        let viewController = ErrorAlertViewController(errorType: errorType)
//        viewController.modalPresentationStyle = .overFullScreen
//        viewController.modalTransitionStyle = .crossDissolve
//        navigationController.present(viewController, animated: true)
//    }
}
