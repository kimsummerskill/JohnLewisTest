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
    let priceString: String
    
    private enum CodingKeys: String, CodingKey {
        case now = "now"
        case currency = "currency"
    }
    
    // In the models we can use 'guards' or 'try, catch' to ensure our values are checked before they are assigned
    // that said, integration tests should also ensure that the data vaues we get retuened are correct.
    // For the purposes of the test I am going to assume that integration testing is running and that the
    // data we get is what we expect.
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        now = try container.decode(String.self, forKey: .now)
        
        // I'm using the currency field to create the currency symbol.
        if let nowVal = Double(now) {
            let currencyCode = try container.decode(String.self, forKey: .currency)
            priceString = Conversion().currencyString(with: currencyCode, value: nowVal)
        }
        else {
            priceString = now
        }
    }
}
