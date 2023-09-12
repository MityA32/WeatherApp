//
//  Fetchable.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import RxSwift

protocol Fetchable {
    func fetchWeather(from url: URL) -> Single<WeatherForecastList>
}
