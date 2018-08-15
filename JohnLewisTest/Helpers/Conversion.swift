//
//  Conversion.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 15/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation

class Conversion {
    open func currencyString(with currencyCode: String, value: Double) -> String {
        
        let price = NSNumber(value: value)
        let formatter = NumberFormatter()
        formatter.currencyCode = currencyCode
        formatter.numberStyle = NumberFormatter.Style.currency
        
        if let price = formatter.string(from: price) {
            return price
        }
        else {
            return "\(value)"
        }
    }
}
