//
//  EarthquakeModel.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import Foundation

struct Earthquake: Codable {
    let magnitude: Double
    let place: String
    let time: Date
    let url: URL
    let latitude: Double
    let longitude: Double
}
