//
//  PriceModel.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation

struct PriceModel: Decodable {
    let now: String
    
    private enum CodingKeys: String, CodingKey {
        case now = "now"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        now = try container.decode(String.self, forKey: .now)
    }
}
