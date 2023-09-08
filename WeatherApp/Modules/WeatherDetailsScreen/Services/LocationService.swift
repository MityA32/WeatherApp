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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let clError = error as? CLError {
               switch clError.code {
               case .locationUnknown:
                   print("Location is unknown.")
               case .denied:
                   print("Location access is denied by the user.")
               // Handle other error codes as needed.
               default:
                   print("Location manager error: \(clError.localizedDescription)")
               }
           } else {
               print("Unknown error occurred: \(error.localizedDescription)")
           }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            // Permission granted, you can now perform location-related tasks
            
            locationManager.startUpdatingLocation()

            print("authorized")
            // Do something here
            
        case .denied, .restricted: break
            // Permission denied or restricted, handle accordingly (e.g., show an alert)
            // You can provide instructions on how to enable location services in your app's settings.
            print("denied, restricted")
        default:
            // Handle other cases as needed
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
