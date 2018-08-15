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
    let imageURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case productId = "productId"
        case price = "price"
        case title = "title"
        case image = "image"
    }
    
    // In the models we can use 'guards' or 'try, catch' to ensure our values are checked before they are assigned
    // that said, integration tests should also ensure that the data vaues we get retuened are correct.
    // For the purposes of the test I am going to assume that integration testing is running and that the
    // data we get is what we expect.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productId = try container.decode(String.self, forKey: .productId)
        price = try container.decode(PriceModel.self, forKey: .price)
        title = try container.decode(String.self, forKey: .title)
        
        let imageString = try container.decode(String.self, forKey: .image)
        
        if let imgURL = URL(string: "https:\(imageString)")  {
            imageURL = imgURL
        }
        else {
            imageURL = nil
        }
    }
}
