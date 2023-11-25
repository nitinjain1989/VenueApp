//
//  NetworkError.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

protocol Errorable: Error {
    var errorDescription: String { get }
}

enum NetworkError: Errorable {
    var errorDescription: String {
        
        switch self {
        case .badRequest:
            return "badRequest"
        case .notFound:
            return "notFound"
        case .parsingError:
            return "parsingError"
        }
    }
    
    case badRequest
    case notFound
    case parsingError

}
