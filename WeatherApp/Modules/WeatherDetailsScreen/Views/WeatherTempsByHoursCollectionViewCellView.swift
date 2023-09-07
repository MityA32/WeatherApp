//
//  WeatherTempsByHoursCollectionViewCellView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import UIKit

final class WeatherTempsByHoursCollectionViewCellView: UIView {
    
    private let infoStackView = UIStackView()
    private let timeLabel = UILabel()
    private let weatherConditionImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    private func setupViews() {
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.text = "--"
        timeLabel.textAlignment = .center
        
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionImageView.image = AssetImage.whiteDayCloudy
        weatherConditionImageView.contentMode = .scaleAspectFit
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "--˚"
        temperatureLabel.textAlignment = .center
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(timeLabel)
        infoStackView.addArrangedSubview(weatherConditionImageView)
        infoStackView.addArrangedSubview(temperatureLabel)
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func setTime(_ time: String) {
        timeLabel.text = time
    }
    
    func setImage(_ image: UIImage?) {
        weatherConditionImageView.image = image
    }
    
    func setTemp(_ temp: Int) {
        temperatureLabel.text = "\(temp)˚"
    }
}
