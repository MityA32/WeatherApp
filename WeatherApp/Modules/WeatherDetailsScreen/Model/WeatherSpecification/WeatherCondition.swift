//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import UIKit

enum WeatherCondition: CaseIterable {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds
}

extension WeatherCondition {
    var main: String {
        switch self {
        case .thunderstorm:
            return "Thunderstorm"
        case .drizzle:
            return "Drizzle"
        case .rain:
            return "Rain"
        case .snow:
            return "Snow"
        case .atmosphere:
            return "Atmosphere"
        case .clear:
            return "Clear"
        case .clouds:
            return "Clouds"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .thunderstorm, .atmosphere:
            return UIImage(named: "ic_white_day_thunder")
        case .drizzle, .snow:
            return UIImage(named: "ic_white_day_rain")
        case .rain:
            return UIImage(named: "ic_white_day_shower")
        case .clear:
            return UIImage(named: "ic_white_day_bright")
        case .clouds:
            return UIImage(named: "ic_white_day_cloudy")
        }
    }
    var nightImage: UIImage? {
        switch self {
            
        case .thunderstorm, .atmosphere:
            return UIImage(named: "ic_white_night_thunder")
        case .drizzle, .snow:
            return UIImage(named: "ic_white_night_rain")
        case .rain:
            return UIImage(named: "ic_white_night_shower")
        case .clear:
            return UIImage(named: "ic_white_night_bright")
        case .clouds:
            return UIImage(named: "ic_white_night_cloudy")
        }
    }
}
