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
    var productsModel: ProductsModel?
    var onDataUpdate:(() -> Void)?
    var categorySearchString: String = "dishwasher"
    let productCellReuseIdentifier = "productGridProductCell"
    required init(router: MVVMRouter) {
        self.router = router
    }
    
    func fetchProductCategory(with category: String?) {
       
        if let categoryString = category {
            categorySearchString = categoryString
        }
        
        fetchResults(with: ProductsService.RequestType.productSearch, context: categorySearchString)
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
        productsModel = result
        onDataUpdate?()
    }
    
    // This would be localised in a real world scenario
    func titleForGrid() -> String {
        return "\(categorySearchString.capitalized)s (\(productsModel?.items.count ?? 0))"
    }
    
    // MARK: UICollectionViewDataSource methods
    
    func numberOfItems(in section: Int) -> Int {
        guard let products = productsModel else {
            return 0
        }
        
        return products.items.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cellModel = productsModel?.model(at: indexPath.row) else {
            return ProductGridProductCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productCellReuseIdentifier, for: indexPath) as! ProductGridProductCell
        
        cell.update(with: cellModel)
        
        return cell
    }
}
