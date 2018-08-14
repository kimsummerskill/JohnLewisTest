//
//  SplashScreenViewController.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController, AppNavigation {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Going to present the main flow after the splash screen has loaded for now. Normally you would have it play something
        // or load something or get the app ready and then present the main experience afterwards.
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.flowCoordinator.presentMain()
        }
    }
}
