//
//  MVVMViewController.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

protocol MVVMViewController: class {
    
    associatedtype viewModelType
    
    var viewModel: viewModelType! { get set }
    
}
