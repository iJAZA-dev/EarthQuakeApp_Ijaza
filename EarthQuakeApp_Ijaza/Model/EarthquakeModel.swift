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
}

extension Earthquake {
    init(from feature: EarthquakeResponse.Feature) {
        self.magnitude = feature.properties.mag
        self.place = feature.properties.place
        self.time = Date(timeIntervalSince1970: feature.properties.time / 1000)
        self.number = feature.properties.code
        self.depth = feature.geometry.coordinates[2]
        self.url = feature.properties.url
    }
}


//
//struct Earthquake: Codable {
//    let magnitude: Double
//    let place: String
//    let time: Date
//    let url: URL
//    let latitude: Double
//    let longitude: Double
//    let depth: Double
//
//    enum CodingKeys: String, CodingKey {
//        case magnitude = "mag"
//        case place
//        case time
//        case url
//        case coordinates
//    }
//
//    enum PropertiesCodingKeys: String, CodingKey {
//        case properties
//        case geometry
//    }
//
//    enum GeometryCodingKeys: String, CodingKey {
//        case coordinates
//    }
//
//    init(from decoder: Decoder) throws {
//        let container   = try decoder.container(keyedBy: PropertiesCodingKeys.self)
//        let properties  = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
//        let timestamp   = try properties.decode(Double.self, forKey: .time)
//        let geometry    = try container.nestedContainer(keyedBy: GeometryCodingKeys.self, forKey: .geometry)
//        let coordinates = try geometry.decode([Double].self, forKey: .coordinates)
//
//        magnitude = try properties.decode(Double.self, forKey: .magnitude)
//        place = try properties.decode(String.self, forKey: .place)
//        time = Date(timeIntervalSince1970: timestamp / 1000)
//        url = try properties.decode(URL.self, forKey: .url)
//        longitude = coordinates[0]
//        latitude = coordinates[1]
//        depth = coordinates[2]
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container   = encoder.container(keyedBy: PropertiesCodingKeys.self)
//        var properties  = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
//        let timestamp   = time.timeIntervalSince1970 * 1000
//        var geometry    = container.nestedContainer(keyedBy: GeometryCodingKeys.self, forKey: .geometry)
//        let coordinates = [longitude, latitude]
//
//        try properties.encode(magnitude, forKey: .magnitude)
//        try properties.encode(place, forKey: .place)
//        try properties.encode(timestamp, forKey: .time)
//        try properties.encode(url, forKey: .url)
//        try geometry.encode(coordinates, forKey: .coordinates)
//    }
//}
//
//struct EarthquakeResponse: Codable {
//    let features: [Earthquake]
//
//    enum CodingKeys: String, CodingKey {
//        case features
//    }
//}
