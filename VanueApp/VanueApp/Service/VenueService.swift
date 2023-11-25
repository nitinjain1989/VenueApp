//
//  VenueService.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

struct EndPoint: Requestable {
    var queryItems: [String : Any]?
    
    init(queryItems: [String : Any]) {
        self.queryItems = queryItems
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var params: [String : Any]? {
        nil
    }
    
    var path: String {
        return "2/venues"
    }
    
    var endpoint: ApiEndpointType {
        return ApiEndpoint.endPoint(path: self.path)
    }
    
    var method: HTTPMethod {
        return .GET
    }
}

protocol VenueServiceServisable {
   
    func getVenues(page: Int, perPage: Int, lat: Double, lon: Double, range: String, clientId: String, completionHandler: @escaping ((Result<VenueListResponse, Error>) -> Void))
}

final class VenueService: VenueServiceServisable {
    
    private let apiService: APIServicable
    
    init(apiService: APIServicable) {
        self.apiService = apiService
    }
    
    func getVenues(page: Int, perPage: Int, lat: Double, lon: Double, range: String, clientId: String, completionHandler: @escaping ((Result<VenueListResponse, Error>) -> Void)) {
        
        var query = [String: Any]()
        query["page"] = page
        query["per_page"] = perPage
        query["client_id"] = clientId
        query["range"] = range
        query["lat"] = lat
        query["lon"] = lon
        
        let endPoint = EndPoint(queryItems: query)
        self.apiService.getData(endPoint, type: VenueListResponse.self, errorType: NetworkError.self) { result in
            completionHandler(result)
        }
    }
}
