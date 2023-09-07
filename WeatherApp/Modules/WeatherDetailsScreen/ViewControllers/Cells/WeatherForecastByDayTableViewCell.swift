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
    
    func setSelected(_ selected: Bool, animated: Bool, shadowColor: UIColor?) {
        super.setSelected(selected, animated: animated)
        cellView.setupElementsStyle(isSelected: selected)
        contentView.layer.shadowOpacity = selected ? 0.25 : 0
        contentView.layer.shadowRadius = selected ? 15.0 : 0
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowColor = selected ? (shadowColor ?? .blue).cgColor : UIColor.clear.cgColor
        contentView.layer.masksToBounds = false

    }
    
    func findMostTimesCondition(by weatherData: [Weather]) -> UIImage? {
        var conditionCounts: [UIImage: Int] = [:]
        
        
        let filteredWeatherData = weatherData.filter { weather in
            print(weather.time)
            if let hourString = weather.time.split(separator: ":").first,
               let hour = Int(hourString),
               hour >= 9 && hour <= 18 {
                return true
            }
            return false
        }
        
        for weather in filteredWeatherData {
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
