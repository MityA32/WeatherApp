//
//  WeatherDetailsView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 04.09.2023.
//

import UIKit

class WeatherDetailsView: UIView {

    private let dateLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let weatherDetailsStackView = UIStackView()
    
    private let temperatureView = WeatherDetailsElementView(type: .maxMinTemp)
    
    private let humidityView = WeatherDetailsElementView(type: .humidity)
    
    private let windInfoView = WeatherDetailsElementView(type: .wind)
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "hex_4A90E2")
        setupWeatherImageView()
        setupWeatherDetailsStackView()
        setupDateLabel()
    }
    
    private func setupDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = Date().formattedForWeatherDetails
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: weatherImageView.topAnchor, constant: 10)
        ])
    }
    
    private func setupWeatherImageView() {
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.image = AssetImage.whiteDayCloudy
        weatherImageView.contentMode = .scaleAspectFit
        addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            
            weatherImageView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -16),
            weatherImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            weatherImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func setupWeatherDetailsStackView() {
        weatherDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherDetailsStackView.axis = .vertical
        weatherDetailsStackView.distribution = .fillEqually
        weatherDetailsStackView.spacing = 8
        weatherDetailsStackView.addArrangedSubview(temperatureView)
        weatherDetailsStackView.addArrangedSubview(humidityView)
        weatherDetailsStackView.addArrangedSubview(windInfoView)
        addSubview(weatherDetailsStackView)
        
        NSLayoutConstraint.activate([
            weatherDetailsStackView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            weatherDetailsStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            weatherDetailsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            weatherDetailsStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            weatherDetailsStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
    
    func config(from model: [Weather]) {
        
        guard let currentWeather = model.first else { return }
        let isToday = Date().formattedForWeatherDetails == currentWeather.weekdayDate
        let maxMinTemps = model.maxMinTemps
        setTemp(max: maxMinTemps.0, min: maxMinTemps.1)
        setDate(currentWeather.weekdayDate)
        setWeatherImage(isToday ? currentWeather.condition : model.mostTimesConditionImage)
        setHumidity(level: isToday ? "\(currentWeather.humidity)" : model.avarageHumidity)
        setWind(
            speed: isToday ? "\(Int(currentWeather.windSpeed))" : model.avarageWindSpeed,
            direction: isToday ? currentWeather.windDirection : model.mostFrequentWindDirection
        )
    }

    private func setTemp(max: Int, min: Int) {
        temperatureView.setLabel(with: "\(max)º/ \(min)º")
    }
    
    private func setHumidity(level: String) {
        humidityView.setLabel(with: "\(level)%")
    }
    
    private func setWind(speed: String, direction: UIImage?) {
        windInfoView.setLabel(with: "\(speed)m/s")
        windInfoView.setTrailingImage(with: direction)
    }
    
    private func setDate(_ date: String) {
        dateLabel.text = date
    }
    
    private func setWeatherImage(_ image: UIImage?) {
        weatherImageView.image = image
    }
}
