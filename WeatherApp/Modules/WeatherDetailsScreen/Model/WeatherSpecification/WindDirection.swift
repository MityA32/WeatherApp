//
//  WindDirection.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 05.09.2023.
//

import UIKit

enum WindDirection: CaseIterable {
    case north
    case northEast
    case east
    case southEast
    case south
    case southWest
    case west
    case northWest
}

extension WindDirection {
    var degrees: [Int] {
        switch self {
        case .north:
            return Array(338...359) + Array(0...22)
        case .northEast:
            return Array(23...67)
        case .east:
            return Array(68...112)
        case .southEast:
            return Array(113...157)
        case .south:
            return Array(158...202)
        case .southWest:
            return Array(203...247)
        case .west:
            return Array(248...292)
        case .northWest:
            return Array(293...337)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .north:
            return UIImage(named: "icon_wind_n")
        case .northEast:
            return UIImage(named: "icon_wind_ne")
        case .east:
            return UIImage(named: "icon_wind_e")
        case .southEast:
            return UIImage(named: "icon_wind_se")
        case .south:
            return UIImage(named: "icon_wind_s")
        case .southWest:
            return UIImage(named: "icon_wind_sw")
        case .west:
            return UIImage(named: "icon_wind_w")
        case .northWest:
            return UIImage(named: "icon_wind_nw")
        }
    }
    
    static func direction(forDegree degree: Int) -> WindDirection? {
        for direction in WindDirection.allCases {
            if direction.degrees.contains(degree) {
                return direction
            }
        }
        return nil
    }
}
