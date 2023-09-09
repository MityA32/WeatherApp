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
        timeLabel.adjustsFontSizeToFitWidth = true
        
        weatherConditionImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherConditionImageView.image = AssetImage.whiteDayCloudy
        weatherConditionImageView.contentMode = .scaleAspectFit
        
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.text = "--º"
        temperatureLabel.textColor = .white
        temperatureLabel.font = .systemFont(ofSize: 20, weight: .medium)
        temperatureLabel.adjustsFontSizeToFitWidth = true
        temperatureLabel.textAlignment = .center
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.addArrangedSubview(timeLabel)
        infoStackView.addArrangedSubview(weatherConditionImageView)
        infoStackView.addArrangedSubview(temperatureLabel)
        infoStackView.axis = .vertical
        infoStackView.distribution = .fillEqually
        addSubview(infoStackView)
        
        NSLayoutConstraint.activate([
            infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            infoStackView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            infoStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func setTime(_ time: String) {
        let mainTimeFont = UIFont.systemFont(ofSize: 20, weight: .medium)
        let mainTimeAttributes: [NSAttributedString.Key: Any] = [
            .font: mainTimeFont,
            .foregroundColor: UIColor.white
        ]
        
        let smallDigitsFont = UIFont.systemFont(ofSize: mainTimeFont.pointSize / 1.75, weight: .medium)
        let smallDigitsAttributes: [NSAttributedString.Key: Any] = [
            .font: smallDigitsFont,
            .baselineOffset: smallDigitsFont.pointSize / 2,
            .foregroundColor: UIColor.white
        ]

        let mainTimeString = NSAttributedString(string: time, attributes: mainTimeAttributes)
        let smallDigitsString = NSAttributedString(string: "00", attributes: smallDigitsAttributes)

        let combinedString = NSMutableAttributedString()
        combinedString.append(mainTimeString)
        combinedString.append(smallDigitsString)
        timeLabel.attributedText = combinedString
        timeLabel.textAlignment = .center
        timeLabel.numberOfLines = 1
    }


    func setImage(_ image: UIImage?) {
        weatherConditionImageView.image = image
    }
    
    func setTemp(_ temp: Int) {
        temperatureLabel.text = "\(temp)º"
    }
}
