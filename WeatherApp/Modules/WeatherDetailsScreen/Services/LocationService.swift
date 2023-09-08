//
//  LocationService.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
    weak var delegate: LocationServiceDelegate? 
    let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationAuth() {
        DispatchQueue.global(qos: .default).async { [weak self] in
            if CLLocationManager.locationServicesEnabled() {
                guard let self else { return }
                locationManager.requestAlwaysAuthorization()
            }
        }
    }
    
    func getCityNameFromLocation(_ location: CLLocation) {
        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first, let city = placemark.locality {
                print("City: \(city)")
                self?.delegate?.locationServiceDidUpdateCityName(cityName: city)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            print("authorized")
        case .denied, .restricted:
            print("denied, restricted")
            break
        default:
            print("default")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update locations")
        locationManager.stopUpdatingLocation()
        if let location = locations.last {
            getCityNameFromLocation(location)
        }
    }
}

protocol LocationServiceDelegate: AnyObject {
    func locationServiceDidUpdateCityName(cityName: String)
}
