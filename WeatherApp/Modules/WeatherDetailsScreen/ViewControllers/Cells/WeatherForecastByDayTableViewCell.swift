//
//  WeatherForecastByDayTableViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 06.09.2023.
//

import UIKit

class WeatherForecastByDayTableViewCell: UITableViewCell {

    let cellView = WeatherForecastByDayTableViewCellView()
    
    static let id = "\(WeatherForecastByDayTableViewCell.self)"

    func config(from model: [Weather]) {
        contentView.addSubview(cellView)
        guard let weekday = model.first?.weekdayDate.prefix(2) else { return }
        var maxTemp = Int.min
        var minTemp = Int.max

        for weather in model {
            if weather.temp > maxTemp {
                maxTemp = weather.temp
            }
            if weather.temp < minTemp {
                minTemp = weather.temp
            }
        }
        cellView.setupByModel(
            weekday: String(weekday),
            maxMinTemps: "\(maxTemp)˚ / \(minTemp)˚",
            condition: findMostTimesCondition(by: model))
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
    }
    
    func findMostTimesCondition(by weatherData: [Weather]) -> UIImage? {
        var conditionCounts: [UIImage: Int] = [:]
        for weather in weatherData {
            if let conditionImage = weather.condition {
                if let count = conditionCounts[conditionImage] {
                    conditionCounts[conditionImage] = count + 1
                } else {
                    conditionCounts[conditionImage] = 1
                }
            }
        }
        var mostStoredConditionImage: UIImage? = nil
        var maxCount = 0

        for (conditionImage, count) in conditionCounts {
            if count > maxCount {
                maxCount = count
                mostStoredConditionImage = conditionImage
            }
        }
        return mostStoredConditionImage
    }
}
