//
//  Date+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import Foundation

extension Date {
    var formattedForWeatherDetails: String {
        self.formatted(.dateTime.weekday(.abbreviated)).uppercased() + ", " + self.formatted(.dateTime.day(.twoDigits).month(.wide))
    }
}

extension Date {
    func formattedTo24Hour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter.string(from: self)
    }
}
