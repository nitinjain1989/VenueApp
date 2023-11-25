//
//  Parser.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

struct Parser {
    
    static func parse<T: Decodable>(toType: T.Type, data: Data) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch let error as NSError {
            return .failure(error)
        }
    }
}
