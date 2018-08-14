//
//  ProductsModel.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation

struct ProductsModel: Decodable {
    let items: [ProductModel]
    
    private enum CodingKeys: String, CodingKey {
        case products = "products"
    }
    
    init(from decoder: Decoder) throws {
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try containter.decode([ProductModel].self, forKey: .products)
    }
}

extension ProductsModel {
    func model(at index: Int) -> ProductModel? {
        
        guard items.count > index else {
            return nil
        }
        
        return items[index]
    }
}
