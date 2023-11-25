//
//  VenueViewModel.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

protocol VenueViewModelDelegate: AnyObject {
    func updateList()
}


protocol VenueViewModelType {
    
    var delegate: VenueViewModelDelegate? { get set }
    var venues: [VenueCellModel] { get }
    
    func getVenues()
}

final class VenueViewModel: VenueViewModelType {
    
    private let clientId = "Mzg0OTc0Njl8MTcwMDgxMTg5NC44MDk2NjY5"
    private let perPage: Int = 10
    private var page: Int = 1
    private let latitude: Double = 12.971599
    private let longitude: Double = 77.594566
    private let range: String = "12mi"
    private let service: VenueServiceServisable
    private var isLoading = false
    var venues: [VenueCellModel] = []
    weak var delegate: VenueViewModelDelegate?
    
    init(service: VenueServiceServisable) {
        
        self.service = service
    }
    
    func getVenues() {
        guard !isLoading else {
            return
        }
        isLoading = true
        self.service.getVenues(page: page, perPage: perPage, lat: latitude, lon: longitude, range: range, clientId: clientId) { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.handleResponse(model: model)
            case .failure(let error):
                self?.isLoading = false
                break
            }
        }
    }
    
    private func handleResponse(model: VenueListResponse) {
        self.isLoading = false
        if let venuesList = model.venues {
            
            let venues =  venuesList.compactMap { venue in
                var address = venue.address ?? ""
                if let city = venue.city {
                    address += " \(city)"
                }
                if let country = venue.country {
                    address += " \(country)"
                }
                
                if let postalCode = venue.postalCode {
                    address += " \(postalCode)"
                }
                return VenueCellModel(title: venue.name ?? "", subTitle: address)
            }
            
            if page == 1 {
                self.venues = venues
            } else {
                self.venues.append(contentsOf: venues)
            }
            DispatchQueue.main.async { [weak self] in
                self?.delegate?.updateList()
            }
            
        }
        
        if let nextPage = model.meta?.took {
            self.page = nextPage
        }
    }
}
