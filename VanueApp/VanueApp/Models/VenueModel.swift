//
//  VenueModel.swift
//  VanueApp
//
//  Created by Nitin Jain on 25/11/23.
//

import Foundation

// MARK: - VenueListResponse
struct VenueListResponse: Codable {
    let venues: [Venue]?
    let meta: Meta?
}

// MARK: - Meta
struct Meta: Codable {
    let total, took, page, perPage: Int?
    let geolocation: Geolocation?

    enum CodingKeys: String, CodingKey {
        case total, took, page
        case perPage = "per_page"
        case geolocation
    }
}

// MARK: - Geolocation
struct Geolocation: Codable {
    let lat, lon: Double?
    let city, state, country, postalCode: String?
    let displayName: String?
    let metroCode: String?
    let range: String?

    enum CodingKeys: String, CodingKey {
        case lat, lon, city, state, country
        case postalCode = "postal_code"
        case displayName = "display_name"
        case metroCode = "metro_code"
        case range
    }
}

// MARK: - Venue
struct Venue: Codable {
    let state: String?
    let nameV2, postalCode, name: String?
    let links: [String]?
    let timezone: String?
    let url: String?
    let score: Int?
    let location: Location?
    let address: String?
    let country: String?
    let hasUpcomingEvents: Bool?
    let numUpcomingEvents: Int?
    let city, slug, extendedAddress: String?
    let stats: Stats?
    let id, popularity: Int?
    let accessMethod: String?
    let metroCode, capacity: Int?
    let displayLocation: String?

    enum CodingKeys: String, CodingKey {
        case state
        case nameV2 = "name_v2"
        case postalCode = "postal_code"
        case name, links, timezone, url, score, location, address, country
        case hasUpcomingEvents = "has_upcoming_events"
        case numUpcomingEvents = "num_upcoming_events"
        case city, slug
        case extendedAddress = "extended_address"
        case stats, id, popularity
        case accessMethod = "access_method"
        case metroCode = "metro_code"
        case capacity
        case displayLocation = "display_location"
    }
}

// MARK: - Location
struct Location: Codable {
    let lat, lon: Double?
}

// MARK: - Stats
struct Stats: Codable {
    let eventCount: Int?

    enum CodingKeys: String, CodingKey {
        case eventCount = "event_count"
    }
}

