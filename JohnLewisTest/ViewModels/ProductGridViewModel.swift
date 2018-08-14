//
//  ProductGridViewModel.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ProductGridViewModel: MVVMViewModel {
    var router: MVVMRouter
    var onDataUpdate:(() -> Void)?
    
    required init(router: MVVMRouter) {
        self.router = router
    }
    
    
}
