//
//  WeatherForecastProvider.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import RxSwift
import RxCocoa

final class WeatherForecastProvider {
    
    private let disposeBag = DisposeBag()
    private let weatherFetcher: Fetchable
    private let weatherParser: Parseable
    
    let inCity = PublishSubject<String>()
    let outWeatherForecast = PublishSubject<[Weather]>()
    
    init(fetcher: Fetchable, parser: Parseable) {
        self.weatherFetcher = fetcher
        self.weatherParser = parser
        setupRx()
    }
    
    private func setupRx() {
        inCity
            .flatMap { [weak self] cityName -> Single<WeatherForecastList> in
                guard let self = self,
                      let cityNameEncoded = cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = CustomURL.byCityName(cityNameEncoded).url
                else { return Single.error(NSError(domain: "Invalid URL", code: 0, userInfo: nil)) }
                return self.weatherFetcher.fetchWeather(from: url)
            }
            .map { [weak self] weatherForecast -> [Weather] in
                return self?.weatherParser.parseWeather(weatherForecast) ?? []
            }
            .bind(to: outWeatherForecast)
            .disposed(by: disposeBag)
    }
}

