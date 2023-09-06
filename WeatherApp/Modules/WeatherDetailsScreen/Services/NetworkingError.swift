//
//  NetworkingError.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import Foundation

enum NetworkingError: Swift.Error {
    case invalidData
    case invalidDecoding
    case invalidURL
}
