//
//  WeatherDetailsElementView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 07.09.2023.
//

import UIKit

final class WeatherDetailsElementView: UIView {
    
    let leadingImage = UIImageView()
    let label = UILabel()
    let trailingImage = UIImageView()
    
    var type: WeatherDetailsElementViewType
    
    init(type: WeatherDetailsElementViewType) {
        self.type = type
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        setupViews()
        
    }
    
    private func setupViews() {
        setupLeadingImage()
        if type == .wind {
            setupTrailingImage()
        }
        setupLabel()
    }
    
    private func setupLeadingImage() {
        leadingImage.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .maxMinTemp:
            leadingImage.image = AssetImage.temperature
        case .humidity:
            leadingImage.image = AssetImage.humidity
        case .wind:
            leadingImage.image = AssetImage.wind
        }
        leadingImage.contentMode = .center
        addSubview(leadingImage)
        NSLayoutConstraint.activate([
            leadingImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            leadingImage.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            leadingImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            leadingImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .maxMinTemp:
            label.text = "--º/ --º"
        case .humidity:
            label.text = "--%"
        case .wind:
            label.text = "--m/s"
        }
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .left
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingImage.trailingAnchor, constant: 8),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        switch type {
        case .maxMinTemp, .humidity:
            label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        case .wind:
            label.trailingAnchor.constraint(equalTo: trailingImage.leadingAnchor, constant: -8).isActive = true
        }
    }
    
    private func setupTrailingImage() {
        trailingImage.translatesAutoresizingMaskIntoConstraints = false
        trailingImage.image = UIImage()
        trailingImage.contentMode = .scaleAspectFill
        addSubview(trailingImage)
        
        NSLayoutConstraint.activate([
            trailingImage.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            trailingImage.topAnchor.constraint(equalTo: topAnchor),
            trailingImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingImage.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setLabel(with text: String) {
        label.text = text
    }
    
    func setTrailingImage(with image: UIImage?) {
        trailingImage.image = image
    }
}

enum WeatherDetailsElementViewType {
    case maxMinTemp
    case humidity
    case wind
}
