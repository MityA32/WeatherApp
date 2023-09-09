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
    private let weatherParser: WeatherParseable
    
    let inCity = PublishRelay<String>()
    let outWeatherForecast = PublishRelay<[Weather]>()
    
    init(fetcher: Fetchable, parser: WeatherParseable) {
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
                    .catch { error in
                       Single.just(WeatherForecastList(list: [], city: WeatherCity(name: "--")))
                   }
            }
            .map { [weak self] weatherForecast -> [Weather] in
                self?.weatherParser.parseWeather(weatherForecast) ?? []
            }
            .bind(to: outWeatherForecast)
            .disposed(by: disposeBag)
    }
}

