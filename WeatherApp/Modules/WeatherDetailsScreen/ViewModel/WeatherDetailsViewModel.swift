//
//  WeatherDetailsViewModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import RxSwift
import RxRelay

final class WeatherDetailsViewModel {
    
    private let model = WeatherDetailsModel()
    
    private let disposeBag = DisposeBag()
    let inCity = BehaviorRelay<String>(value: "Kyiv")
    private let _outWeather = PublishRelay<[String : [Weather]]>()
    private(set) lazy var outWeather = self._outWeather.asObservable()
    
    
    init() {
        setupRx()
    }
    
    private func setupRx() {
        inCity
            .bind(to: model.inCity)
            .disposed(by: disposeBag)
        model.outWeatherForecast
            .bind(to: _outWeather)
            .disposed(by: disposeBag)
    }
    
}
