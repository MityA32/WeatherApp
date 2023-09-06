//
//  WeatherForecastParser.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import UIKit

final class WeatherForecastParser: Parseable {
    func parseWeather(_ unparsedWeather: WeatherForecastList) -> [Weather] {
        unparsedWeather.list
            .map { weather in
                let date = Date(timeIntervalSince1970: TimeInterval(weather.date))
                var windDirectionImage: UIImage?
                WindDirection.allCases.forEach {
                    if $0.degrees.contains(weather.wind.deg) { windDirectionImage = $0.image }
                }
                var condition: UIImage?
                
                WeatherCondition.allCases.forEach {
                    if $0.main.contains(weather.weather.first?.main ?? "") {
                        condition = isNight(date: weather.date) ? $0.nightImage : $0.image
                    }
                }
                return Weather(
                    weekdayDate: date.formattedForWeatherDetails ,
                    time: date.formatted(.dateTime.hour()),
                    temp: Int(weather.main.temp - 273),
                    humidity: "\(weather.main.humidity)",
                    windSpeed: "\(weather.wind.speed)",
                    windDirection: windDirectionImage,
                    condition: condition
                    
                )
            }
    }
    
    func isNight(date: Int) -> Bool {
        let time = Date(timeIntervalSince1970: TimeInterval(date)).description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        if let timeDate = dateFormatter.date(from: time) {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: timeDate) - 3
            return hour < 7 || hour > 20
        }
        print("Invalid time format")
        return false
    }
}
