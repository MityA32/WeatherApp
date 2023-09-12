//
//  SearchByMapScreenViewController.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 12.09.2023.
//

import UIKit
import MapKit
import RxSwift
import RxRelay

final class SearchByMapScreenViewController: UIViewController {
    
    private let aboveNavigationBarView = UIView()
    private let customNavigationBar = CustomNavigationBarView(type: .searchPlaceByMap)
    private var mapView = MKMapView()
    
    private var annotations = [MKPointAnnotation]()
    
    let onSelectCity = PublishRelay<String>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
    }
    
    private func setupViews() {
        setupAboveNavigationBarView()
        setupCustomNavigationNar()
        setupMapView()
    }
    
    private func setupAboveNavigationBarView() {
        aboveNavigationBarView.translatesAutoresizingMaskIntoConstraints = false
        aboveNavigationBarView.backgroundColor = UIColor(named: "hex_4A90E2")
        view.addSubview(aboveNavigationBarView)
        
        NSLayoutConstraint.activate([
            aboveNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            aboveNavigationBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboveNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboveNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCustomNavigationNar() {
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.delegateDismissViewController = self
        view.addSubview(customNavigationBar)
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension SearchByMapScreenViewController {
    @objc
    private func handleMapTap(_ sender: UITapGestureRecognizer) {
        let locationInView = sender.location(in: mapView)
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)

        if annotations.count >= 1 {
            let lastAnnotation = annotations.removeLast()
            mapView.removeAnnotation(lastAnnotation)
        }

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        annotations.append(annotation)
    }
    
    private func configureSelectedCityName(completion: @escaping (String) -> Void) {
        guard let annotationCoordinates = annotations.first?.coordinate else { return }
        let location = CLLocation(latitude: annotationCoordinates.latitude, longitude: annotationCoordinates.longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if let error = error {
                print("Reverse geocoding failed with error: \(error.localizedDescription)")
                return
            }
            if let placemark = placemarks?.first,
               let city = placemark.locality {
                completion(city)
            }
        })
    }
}

extension SearchByMapScreenViewController: SearchPlaceByMapNavigationBarViewDelegate {
    func tapOnDoneButton() {
        configureSelectedCityName(completion: { [weak self] placeName in
            let alertAboutCity = UIAlertController(title: "Place selected", message: "\(placeName)", preferredStyle: .alert)
            alertAboutCity.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let self else { return }
                self.onSelectCity.accept(placeName)
            })
            alertAboutCity.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alertAboutCity, animated: true)
        })   
    }
    
    func tapOnBackButton() {
        dismiss(animated: true)
    }
}
    
