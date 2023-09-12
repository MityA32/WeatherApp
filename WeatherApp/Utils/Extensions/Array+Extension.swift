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
        let count = self.count
        guard count != 0 else { return 0 }
        var avgDegree = self.reduce(.zero, { $0 + $1.windDirection})
        
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
        let count = self.count
        guard count != 0 else { return "" }
        
        let humidity = self.reduce(.zero, { $0 + $1.humidity })
        
        return "\(Int(Double(humidity) / Double(count)))"
    }
    
    var avarageWindSpeed: String {
        let count = self.count
        guard count != 0 else { return "" }
        
        let speed = self.reduce(.zero, { $0 + $1.windSpeed })
        
        return "\(Int(speed / Double(self.count)))"
    }
}
