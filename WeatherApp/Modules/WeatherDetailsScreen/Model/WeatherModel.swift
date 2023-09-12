//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import Foundation

struct WeatherForecastList: Decodable {
    let list: [WeatherModel]
    let city: WeatherCity
}

struct WeatherModel: Decodable {
    let date: Int
    let main: WeatherMain
    let weather: [WeatherDescription]
    let wind: WeatherWind
    let dateText: String
    
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case main
        case weather
        case wind
        case dateText = "dt_txt"
    }
}

struct WeatherMain: Decodable {
    let temp: Double
    let humidity: Int
}

struct WeatherDescription: Decodable {
    let main: String
}

struct WeatherWind: Decodable {
    let speed: Double
    let deg: Int
}

struct WeatherCity: Decodable {
    let name: String
}
