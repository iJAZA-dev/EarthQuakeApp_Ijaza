//
//  EarthquakeModel.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import Foundation

struct EarthquakeResponse: Decodable {
    let features: [Feature]

    struct Feature: Decodable {
        let properties: Properties
        let geometry: Geometry

        struct Properties: Decodable {
            let mag: Double
            let place: String
            let time: Double
            let url: String
            let code: String
        }

        struct Geometry: Decodable {
            let coordinates: [Double]
        }
    }
}

struct Earthquake {
    let magnitude: Double
    let place: String
    let time: Date
    let depth: Double
    let number: String
    let url: String
    let latitude: Double
    let longitude: Double
    
    
    init(from feature: EarthquakeResponse.Feature) {
        self.magnitude = feature.properties.mag
        self.place = feature.properties.place
        self.time = Date(timeIntervalSince1970: feature.properties.time / 1000)
        self.number = feature.properties.code
        self.depth = feature.geometry.coordinates[2]
        self.url = feature.properties.url
        self.latitude = feature.geometry.coordinates[1]
        self.longitude = feature.geometry.coordinates[0]
    }
}
