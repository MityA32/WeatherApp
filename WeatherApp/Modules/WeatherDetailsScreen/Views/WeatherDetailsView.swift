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
    private let temperatureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let windInfoLabel = UILabel()
    
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
            weatherImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            weatherImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            weatherImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            weatherImageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16)
        ])
    }
    
    private func setupWeatherDetailsStackView() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "--˚/ --˚"
        temperatureLabel.attachImage(AssetImage.temperature, atPosition: .beginning)
        
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.text = "--%"
        humidityLabel.attachImage(AssetImage.humidity, atPosition: .beginning)
        
        windInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        windInfoLabel.text = "--m/s"
        windInfoLabel.attachImage(AssetImage.wind, atPosition: .beginning)
        windInfoLabel.attachImage(AssetImage.windDirectionNorth, atPosition: .end)
        
        weatherDetailsStackView.translatesAutoresizingMaskIntoConstraints = false
        weatherDetailsStackView.axis = .vertical
        weatherDetailsStackView.distribution = .fillEqually
        weatherDetailsStackView.addArrangedSubview(temperatureLabel)
        weatherDetailsStackView.addArrangedSubview(humidityLabel)
        weatherDetailsStackView.addArrangedSubview(windInfoLabel)
        addSubview(weatherDetailsStackView)
        
        NSLayoutConstraint.activate([
            weatherDetailsStackView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 16),
            weatherDetailsStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            weatherDetailsStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            weatherDetailsStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 20),
            weatherDetailsStackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
    
    func config(from model: [Weather]) {
        guard let date = model.first?.weekdayDate else { return }
        setDate(date)
    }

    private func setTemp(max: String, min: String) {
        temperatureLabel.text = "\(max)˚/ \(min)˚"
        temperatureLabel.attachImage(AssetImage.temperature, atPosition: .beginning)
    }
    
    private func setHumidity(level: String) {
        humidityLabel.text = "\(level)%"
        humidityLabel.attachImage(AssetImage.humidity, atPosition: .beginning)
    }
    
    private func setWind(speed: String, direction: UIImage?) {
        windInfoLabel.text = "\(speed)m/s"
        windInfoLabel.attachImage(AssetImage.wind, atPosition: .beginning)
        windInfoLabel.attachImage(direction, atPosition: .end)
    }
    
    private func setDate(_ date: String) {
        dateLabel.text = date
    }
}
