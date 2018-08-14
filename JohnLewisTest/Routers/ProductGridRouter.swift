//
//  ProductGridRouter.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ProductGridRouter: MVVMRouter {
    var baseViewController: UIViewController?
    
    func presentAsRootViewController(on window: UIWindow) {
        
        guard let productGridViewController: ProductGridViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "productGridViewController") as? ProductGridViewController else {
            fatalError("Unable to instantiate ProductGridViewController")
        }
        
        let productGridViewModel = ProductGridViewModel(router: self)
        
        productGridViewController.viewModel = productGridViewModel
        baseViewController = productGridViewController
        
        let transition = CATransition()
        transition.type = kCATransitionFade
        
        let navController = UINavigationController()
        navController.pushViewController(productGridViewController, animated: false)
        window.set(rootViewController: navController, withTransition: transition)
        
    }
    
    func enqueueRoute(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
        
    }
    
    func present(on baseViewController: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
    
    func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
        
    }
}
