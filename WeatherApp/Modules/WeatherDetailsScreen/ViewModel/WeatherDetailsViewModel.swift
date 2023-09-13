//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import RxSwift
import RxRelay
import OrderedCollections

final class WeatherDetailsViewModel {
    
    private let model = WeatherDetailsModel()
    
    private let disposeBag = DisposeBag()
    let inCity = PublishRelay<String>()
    let inSelectedIndexOfDay = PublishRelay<Int>()
    private let _outWeather = PublishRelay<OrderedDictionary<String, [Weather]>>()
    private(set) lazy var outWeather = self._outWeather.asObservable()
    private let _outWeatherForecastBySelectedDay = PublishRelay<[Weather]>()
    private(set) lazy var outWeatherForecastBySelectedDay = self._outWeatherForecastBySelectedDay.asObservable()
    
    init() {
        setupRx()
    }
    
    private func setupRx() {
        inCity
            .bind(to: model.inCity)
            .disposed(by: disposeBag)
        inSelectedIndexOfDay
            .bind(to: model.inSelectedIndexOfDay)
            .disposed(by: disposeBag)
        model.outWeatherForecast
            .bind(to: _outWeather)
            .disposed(by: disposeBag)
        model.outWeatherForecastBySelectedDay
            .bind(to: _outWeatherForecastBySelectedDay)
            .disposed(by: disposeBag)
    }
}
