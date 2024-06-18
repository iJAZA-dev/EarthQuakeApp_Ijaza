//
//  EarthquakeViewModel.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import Foundation

class EarthquakeViewModel {
    let endPoint  = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"

    func getEarthquakeInfo(completed: @escaping(Result<[Earthquake], EQError>) -> Void) {
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidResponse))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let earthquakeInfo = try decoder.decode([Earthquake].self, from: data)
                completed(.success(earthquakeInfo))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
