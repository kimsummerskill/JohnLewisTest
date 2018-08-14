//
//  UICoordinator.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//
// This class would be used to coordinate overarching UI presentations
// it is light in this case as it's a test app but if it were a real application
// it would be coordinating the UI presentation of decision flows.

import UIKit

class UICoordinator: AppNavigation {
    
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    // Present the main experience
    func presentMain() {
    
    }
}
