//
//  AppNavigation.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

protocol  AppNavigation {
    
    var appDelegate: AppDelegate { get }
    var flowCoordinator: FlowCoordinator { get }
    
}

extension AppNavigation {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var flowCoordinator: FlowCoordinator {
        return appDelegate.flowCoordinator
    }
    
}
