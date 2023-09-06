//
//  String+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 04.09.2023.
//

import UIKit

extension String {
    var image: UIImage? {
        UIImage(named: self)
    }
}
