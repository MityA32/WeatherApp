//
//  Array+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 07.09.2023.
//

import UIKit

extension Array where Element == Weather {
    var mostTimesConditionImage: UIImage? {
        var conditionCounts: [UIImage: Int] = [:]
        
        let filteredWeatherData = self.filter { weather in
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
        
        guard let mostStoredConditionImage else { return AssetImage.whiteDayCloudy }
        return mostStoredConditionImage
    }
    
    var mostFrequentWindDirection: Int {
        var avgDegree = 0
        self.forEach {
            avgDegree += $0.windDirection
        }
        return avgDegree / self.count
    }
    
    var maxMinTemps: (Int, Int) {
        var maxTemp = Int.min
        var minTemp = Int.max

        for weather in self {
            if weather.temp > maxTemp {
                maxTemp = weather.temp
            }
            if weather.temp < minTemp {
                minTemp = weather.temp
            }
        }
        return (maxTemp, minTemp)
    }
    
    var avarageHumidity: String {
        var humidity = 0.0
        self.forEach {
            humidity += Double($0.humidity)
        }
        return "\(Int(humidity / Double(self.count)))"
    }
    
    var avarageWindSpeed: String {
        var speed = 0.0
        self.forEach {
            speed += $0.windSpeed
        }
        return "\(Int(speed / Double(self.count)))"
    }
}
