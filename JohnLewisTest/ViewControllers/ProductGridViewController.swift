//
//  ProductGridViewController.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ProductGridViewController: UIViewController, MVVMViewController {

    var viewModel: ProductGridViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.reloadData()
            }
        }
        
        self.viewModel.fetchProductCategory(with: nil)
        
    }
    
    func reloadData() {
        
    }
}

