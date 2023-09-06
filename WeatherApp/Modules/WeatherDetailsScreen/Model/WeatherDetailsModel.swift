//
//  WeatherDetailsModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 06.09.2023.
//

import RxSwift
import RxCocoa

final class WeatherDetailsModel {
    
    private let weatherProvider = WeatherForecastProvider(fetcher: WeatherNetworkService(), parser: WeatherForecastParser())
    
    private let disposeBag = DisposeBag()
    let inCity = PublishRelay<String>()
    let outWeatherForecast = PublishRelay<[String: [Weather]]>()
    
    init() {
        self.inCity
            .bind(to: self.weatherProvider.inCity)
            .disposed(by: self.disposeBag)
        self.weatherProvider.outWeatherForecast
            .map { weatherData in
                var groupedWeather: [String: [Weather]] = [:]
                for weather in weatherData {
                    if var existingGroup = groupedWeather[weather.weekdayDate] {
                        existingGroup.append(weather)
                        groupedWeather[weather.weekdayDate] = existingGroup
                    } else {
                        groupedWeather[weather.weekdayDate] = [weather]
                    }
                }
                return groupedWeather
            }
            .bind(to: self.outWeatherForecast)
            .disposed(by: self.disposeBag)
    }
}
