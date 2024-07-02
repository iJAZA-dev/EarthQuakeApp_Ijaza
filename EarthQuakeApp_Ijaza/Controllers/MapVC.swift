//
//  MapVC.swift
//  EarthQuakeApp_Ijaza
//
//  Created by Martha on 18/06/2024.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class MapVC: UIViewController {

    private let mapView = MKMapView()
    var viewModel: EarthquakeViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        setupMapView()
        bindViewModel()
    }

    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Earthquake Map"
    }

    private func setupMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.getEarthquakeInfo()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] earthquakes in
                self?.addAnnotations(for: earthquakes)
            })
            .disposed(by: disposeBag)
    }

    private func addAnnotations(for earthquakes: [Earthquake]) {
        let annotations = earthquakes.map { earthquake -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.title = earthquake.place
            annotation.subtitle = "Magnitude: \(earthquake.magnitude)\nTime: \(earthquake.time)"
            annotation.coordinate = CLLocationCoordinate2D(latitude: earthquake.latitude, longitude: earthquake.longitude)
            return annotation
        }
        mapView.addAnnotations(annotations)
        if let firstAnnotation = annotations.first {
            mapView.setRegion(MKCoordinateRegion(center: firstAnnotation.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000), animated: true)
        }
    }
}

