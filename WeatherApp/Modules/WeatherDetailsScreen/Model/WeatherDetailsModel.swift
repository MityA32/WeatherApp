//
//  WeatherDetailsModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 06.09.2023.
//

import RxSwift
import RxCocoa
import OrderedCollections

final class WeatherDetailsModel {
    
    private let weatherProvider = WeatherForecastProvider(fetcher: WeatherNetworkService(), parser: WeatherForecastParser())
    
    private let disposeBag = DisposeBag()
    let inCity = PublishRelay<String>()
    let inSelectedIndexOfDay = BehaviorRelay<Int>(value: 0)
    let outWeatherForecast = PublishRelay<OrderedDictionary<String, [Weather]>>()
    let outWeatherForecastBySelectedDay = PublishRelay<[Weather]>()

    
    
    init() {
        self.inCity
            .debug("inCityModel")
            .bind(to: self.weatherProvider.inCity)
            .disposed(by: self.disposeBag)
        self.weatherProvider.outWeatherForecast
            .map { [weak self] weatherData in
                self?.grouppedWeatherByDay(weatherData: weatherData) ?? [:]
            }
            .bind(to: self.outWeatherForecast)
            .disposed(by: self.disposeBag)
        inSelectedIndexOfDay
            .withLatestFrom(outWeatherForecast) { (selectedIndex, weatherData) in
                let selectedDate = Array(weatherData.keys)[selectedIndex]
                return weatherData[selectedDate] ?? []
            }
            .bind(to: self.outWeatherForecastBySelectedDay)
            .disposed(by: self.disposeBag)
    }
    
    func grouppedWeatherByDay(weatherData: [Weather]) -> OrderedDictionary<String, [Weather]> {
        var groupedWeather: OrderedDictionary<String, [Weather]> = [:]
        for weather in weatherData {
            if var existingGroup = groupedWeather[weather.weekdayDate] {
                existingGroup.append(weather)
                groupedWeather[weather.weekdayDate] = existingGroup
            } else {
                if groupedWeather.count >= 5 {
                    break
                }
                groupedWeather[weather.weekdayDate] = [weather]
            }
        }
        return groupedWeather
    }
}
