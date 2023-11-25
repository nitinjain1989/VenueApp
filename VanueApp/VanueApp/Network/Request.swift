//
//  Request.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

protocol Requestable {
    
    var endpoint: ApiEndpointType { get }
    var urlRequest: URLRequest? { get }
    var header: [String: String]? { get }
    var method: HTTPMethod { get }
    var queryItems: [String: Any]? { get }
    var params: [String: Any]? { get}
}

extension Requestable {
    
    /// Converts a Request instance to an URLRequest instance.
    var url: URL? {
        
        var components = URLComponents(string: self.endpoint.host)!
        components.path = self.endpoint.path
        
        if let queryItems = self.queryItems {
            
            components.queryItems = queryItems.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        return components.url
    }
    
    var urlRequest: URLRequest? {
        
        guard let url = self.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        
        
        for (key,value) in self.header ?? [:] {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        if let params = params, !params.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        
        return urlRequest
    }
}
