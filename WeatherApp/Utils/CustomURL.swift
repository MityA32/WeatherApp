//
//  CustomURL.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import Foundation

enum CustomURL {
    case byCityName(String)
}

extension CustomURL {
    var url: URL? {
        switch self {
        case .byCityName(let cityName):
            return URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(Const.appIDForWeatherAPI)")
        }
    }
}
