//
//  WeatherForecastByDayTableViewCellView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 06.09.2023.
//

import UIKit

final class WeatherForecastByDayTableViewCellView: UIView {
    
    let weekdayLabel = UILabel()
    let maxMinTempsLabel = UILabel()
    let weatherConditionImageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupSubviews()
    }
    
    private func setupSubviews() {
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        weekdayLabel.text = "--"
        weekdayLabel.font = .systemFont(ofSize: 24, weight: .medium)
        weekdayLabel.textColor = .black
        
        addSubview(weekdayLabel)
        
        maxMinTempsLabel.translatesAutoresizingMaskIntoConstraints = false
        maxMinTempsLabel.text = "--˚/ --˚"
        maxMinTempsLabel.textColor = .black
        maxMinTempsLabel.font = .systemFont(ofSize: 24, weight: .medium)
        maxMinTempsLabel.textAlignment = .center
        addSubview(maxMinTempsLabel)
        
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionImageView.image = AssetImage.whiteDayCloudy?.withTintColor(.black, renderingMode: .alwaysTemplate)
        addSubview(weatherConditionImageView)
        
        
        NSLayoutConstraint.activate([
            maxMinTempsLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            maxMinTempsLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            maxMinTempsLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            maxMinTempsLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            weekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekdayLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            weekdayLabel.trailingAnchor.constraint(lessThanOrEqualTo: maxMinTempsLabel.leadingAnchor, constant: -16),
            
            weatherConditionImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            weatherConditionImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            weatherConditionImageView.widthAnchor.constraint(equalTo: weatherConditionImageView.heightAnchor),
            weatherConditionImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
        
    }
    
    
    func setupByModel(weekday: String, maxMinTemps: String, condition: UIImage?) {
        weekdayLabel.text = weekday
        maxMinTempsLabel.text = maxMinTemps
        weatherConditionImageView.image = condition?.withTintColor(.black, renderingMode: .alwaysOriginal)
    }
    
    func setupElementsStyle(isSelected: Bool) {
        weekdayLabel.textColor = UIColor(named: isSelected ? "hex_5A9FF0" : "hex_000000")
        maxMinTempsLabel.textColor = UIColor(named: isSelected ? "hex_5A9FF0" : "hex_000000")
        weatherConditionImageView.image = weatherConditionImageView.image?.withTintColor(UIColor(named: isSelected ? "hex_5A9FF0" : "hex_000000") ?? .black) 
    }
}
