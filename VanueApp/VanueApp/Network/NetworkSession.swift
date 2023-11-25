//
//  NetworkSession.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

protocol NetworkSession {
   func call<E: Errorable>(_ request: Requestable, errorType: E.Type, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask?
}

extension URLSession : NetworkSession {
    
     func call<E>(_ request: Requestable, errorType: E.Type, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask? where E : Errorable {
        
        
        guard let urlRequest = request.urlRequest else {
            completionHandler(.failure(NetworkError.badRequest))
            return nil
        }
        
        let task = self.dataTask(with: urlRequest) {  (data, response, error) in
            
            if let error = error {
                print(error)
                completionHandler(.failure(NetworkError.badRequest))
                return
            }
            
            let acceptedStatusCode = Set(200...399)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            guard acceptedStatusCode.contains(statusCode) else {
                completionHandler(.failure(NetworkError.notFound))
                return
            }
            if let data = data {
                completionHandler(.success(data))
            }
            
        }
        task.resume()
        return task
    }
}
