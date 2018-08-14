//
//  ProductModel.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation

struct ProductModel: Decodable {
    let productId: String
    let price: PriceModel
    let title: String
    let image: String
    
    private enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case price = "price"
        case title = "title"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productId = try container.decode(String.self, forKey: .productId)
        price = try container.decode(PriceModel.self, forKey: .price)
        title = try container.decode(String.self, forKey: .title)
        image = try container.decode(String.self, forKey: .image)
    }
}
