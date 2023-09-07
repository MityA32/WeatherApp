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
        let maxMinTemps = model.maxMinTemps
        cellView.setupByModel(
            weekday: String(weekday),
            maxMinTemps: "\(maxMinTemps.0)º / \(maxMinTemps.1)º",
            condition: model.mostTimesConditionImage
        )
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        contentView.layer.masksToBounds = false
        selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        layer.masksToBounds = false
        layer.shadowColor = (UIColor(named: "hex_5A9FF0") ?? .blue).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0
        layer.shadowOpacity = selected ? 0.25 : 0
        cellView.setupElementsStyle(isSelected: selected)
    }
}
