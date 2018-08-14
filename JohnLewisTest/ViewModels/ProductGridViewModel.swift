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
    let productsService = ProductsService()
    var ProductsModel: ProductsModel?
    var onDataUpdate:(() -> Void)?
    var defaultCategoryString: String = "dishwasher"
    
    required init(router: MVVMRouter) {
        self.router = router
    }
    
    func fetchProductCategory(with category: String?) {
        let categoryString = category == nil ? defaultCategoryString : category
        fetchResults(with: ProductsService.RequestType.productSearch, context: categoryString)
    }

    fileprivate func fetchResults(with requestType: ProductsService.RequestType, context: Any?) {
        switch requestType {
        case ProductsService.RequestType.productSearch:
            guard let context = context as? String else {
                return
            }
            
            productsService.retrieveResults(with: requestType, context: context, completion: { [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .failure(let error):
                    
                    // In a failure scenario we will need to decide what to do given the failure type. For example, if we have data already that
                    // the user can still browse then theres no need to block the screen with a nice connectivity message. Maybe we show a
                    // toast instead. Or if indeed there is no content from the word go then we can have a placeholder view to indicate the
                    // error state in a nice user firnedly way.
                    print("\(error) failing silently for now as this is a test")
                    
                case .success(let value):
                    
                    guard let value = value as? ProductsModel else {
                        return
                    }
                    
                    self.updateResults(with: value)
                    
                }
            })
        }
    }
    
    // Store our results and call the update
    func updateResults(with result: ProductsModel) {
        ProductsModel = result
        onDataUpdate?()
    }
}
