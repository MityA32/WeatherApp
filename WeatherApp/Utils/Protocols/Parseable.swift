//
//  Parseable.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import Foundation

protocol Parseable {
    func parseWeather(_ unparsedWeather: WeatherForecastList) -> [Weather]
}
