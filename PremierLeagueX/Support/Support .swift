//
//  Support .swift
//  PremierLeagueX
//
//  Created by Shrouk Yasser on 19/04/2024.
//

import UIKit


protocol Support {
    func getTopViewController(scope: (_ topVC: UIViewController) -> Void)
}

extension Support {
    internal func getTopViewController(scope: (_ topVC: UIViewController) -> Void) {
        if let keyWindow = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
            if var topController = keyWindow.rootViewController {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                
                scope(topController)
            }
        }
    }
}
