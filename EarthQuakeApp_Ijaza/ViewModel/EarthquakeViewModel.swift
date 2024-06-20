//
//  EarthquakeViewModel.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import Foundation
import RxSwift
import RxCocoa

class EarthquakeViewModel {
    
    let endPoint  = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson"

    func getEarthquakeInfo() -> Observable<[Earthquake]> {
        return Observable.create { observer in
            guard let url = URL(string: self.endPoint) else {
                observer.onError(EQError.invalidResponse)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    observer.onError(EQError.unableToComplete)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    observer.onError(EQError.invalidResponse)
                    return
                }
                
                guard let data = data else {
                    observer.onError(EQError.invalidData)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let earthquakeResponse = try decoder.decode(EarthquakeResponse.self, from: data)
                    let earthquakes = earthquakeResponse.features.map { feature in
                        Earthquake(from: feature)
                    }
                    observer.onNext(earthquakes)
                    observer.onCompleted()
                } catch {
                    observer.onError(EQError.invalidData)
                }
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
