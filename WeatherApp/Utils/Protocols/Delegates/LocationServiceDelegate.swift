//
//  LocationServiceDelegate.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import Foundation

protocol LocationServiceDelegate: AnyObject {
    func locationServiceDidUpdateCityName(cityName: String)
}
