//
//  WeatherNetworkService.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import RxSwift

final class WeatherNetworkService: Fetchable {
    func fetchWeather(from url: URL) -> Single<WeatherForecastList> {
        Single<WeatherForecastList>.create { singleObserver in
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error { print(error.localizedDescription); singleObserver(.failure(NetworkingError.invalidURL)) }
                guard let data else { singleObserver(.failure(NetworkingError.invalidData)); return }
                guard let decodedWeatherForecast = try? JSONDecoder().decode(WeatherForecastList.self, from: data)
                    else { singleObserver(.failure(NetworkingError.invalidDecoding)); return }
                singleObserver(.success(decodedWeatherForecast))
            }
            dataTask.resume()
            return Disposables.create { dataTask.cancel() }
        }
    }
}
