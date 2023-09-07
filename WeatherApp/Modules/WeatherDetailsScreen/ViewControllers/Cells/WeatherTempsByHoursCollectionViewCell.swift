//
//  WeatherTempsByHoursCollectionViewCell.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 07.09.2023.
//

import UIKit

class WeatherTempsByHoursCollectionViewCell: UICollectionViewCell {
    
    static let id = "\(WeatherTempsByHoursCollectionViewCell.self)"
    
    private let cellView = WeatherTempsByHoursCollectionViewCellView()
    
    func config(from model: Weather) {
        cellView.setTime(model.time)
        cellView.setImage(model.condition)
        cellView.setTemp(model.temp)
        
        contentView.addSubview(cellView)
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
}
