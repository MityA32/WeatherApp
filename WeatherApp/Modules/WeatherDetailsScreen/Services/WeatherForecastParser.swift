//
//  WeatherForecastParser.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import UIKit

final class WeatherForecastParser: WeatherParseable {
    func parseWeather(_ unparsedWeather: WeatherForecastList) -> [Weather] {
        unparsedWeather.list
            .map { weather in
                let date = Date(timeIntervalSince1970: TimeInterval(weather.date))
                let descriptionMain = weather.weather.first?.main ?? ""
                let condition = WeatherCondition.allCases
                    .first(where: { $0.main.contains(descriptionMain) })
                    .flatMap({isNight(date: weather.date) ? $0.nightImage : $0.image})
                
                return Weather(
                    weekdayDate: date.formattedForWeatherDetails,
                    time: date.formattedTo24Hour(),
                    temp: Int(weather.main.temp - 273),
                    humidity: weather.main.humidity,
                    windSpeed: weather.wind.speed,
                    windDirection: weather.wind.deg,
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
            let hour = calendar.component(.hour, from: timeDate)
            return hour < 7 || hour > 20
        }
        print("Invalid time format")
        return false
    }
}

