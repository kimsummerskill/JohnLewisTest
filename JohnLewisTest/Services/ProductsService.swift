 //
//  ProductsService.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import Foundation

typealias RequestResult = Result<Any>
typealias RequestCompletionHandler = (RequestResult) -> Void

class ProductsService {
    
    private let baseURL = "https://api.johnlewis.com"
    
    // Error routes
    enum RequestError: Error {
        case invalidData
        case invalidResponse
        case unableToDecodeModels
        case invalidDataObject
        case invalidURLConstruct
        case serviceError(error: Error)
    }
    
    enum RequestType: String {
        case productSearch = "/v1/products/search?q=%@&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20"
    }
    
    // Create a nice URL for our request type, take any parameters in context
    internal func urlFor(requestType: RequestType, context: Any?) -> URL? {
        
        var urlString = "\(baseURL)\(requestType.rawValue)"
        
        switch requestType {
        case .productSearch:
            if let searchString = context as? String {
                
                if let escapedString = searchString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                    urlString = String.init(format: urlString, escapedString)
                }
            }
            else {
                return nil
            }
        }
        
        if let requestURL = URL(string: urlString) {
            return requestURL
        }
        
        return nil
    }
    
    // Retrieve our results, fire off completion when finished. Going to use the new Decodable that they added in Swift 4 for this rather
    // than using the older style 'JSONSerialization.jsonObject' as it is much better and will allow us to one line decode.
    func retrieveResults(with requestType: RequestType, context: Any?, completion: @escaping RequestCompletionHandler) {
        
        guard let url = urlFor(requestType: requestType, context: context) else {
            completion(RequestResult.failure(RequestError.invalidURLConstruct))
            return
        }
        
        let request = URLRequest(url: url)
        
        let _ = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error -> Void in
            
            if let error = error {
                completion(RequestResult.failure(RequestError.serviceError(error: error)))
                return
            }
            
            if let data = data {
                do {
                    let resultObjects = try data.decodeDataToObjects(with: requestType)
                    completion(RequestResult.success(resultObjects))
                    
                }
                catch let error {
                    completion(RequestResult.failure(error))
                    return
                }
            }
            else {
                completion(RequestResult.failure((RequestError.invalidData)))
            }
            
        }).resume()
    }
}

extension Data {
    // Going to use this to decode json data directly to objects using the new
    // Decodable that they added in Swift 4. Pretty convenient, who needs random parser x.
    func decodeDataToObjects(with requestType: ProductsService.RequestType) throws -> Any {
        do {
            switch requestType {
            case .productSearch:
                return try JSONDecoder().decode(ProductsModel.self, from: self)
            }
        }
        catch {
            throw ProductsService.RequestError.unableToDecodeModels
        }
    }
}
