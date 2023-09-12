//
//  WeatherDetailsNavigationBarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import UIKit

final class WeatherDetailsNavigationBarView: UIView {
    
    let placeImageView = UIImageView()
    var placeNameLabel = UILabel()
    let myLocationImageView = UIImageView()
    weak var delegate: NavigateToSearchByPlaceNameScreenDelegate?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(placeNameLabelTapped))
        placeNameLabel.isUserInteractionEnabled = true
        placeNameLabel.addGestureRecognizer(tapGesture)
    }
    
    func setupViews() {
        placeImageView.translatesAutoresizingMaskIntoConstraints = false
        placeImageView.image = AssetImage.place
        
        placeImageView.contentMode = .center
        addSubview(placeImageView)
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.text = "--"
        placeNameLabel.textColor = .white
        addSubview(placeNameLabel)
        myLocationImageView.translatesAutoresizingMaskIntoConstraints = false
        myLocationImageView.image = AssetImage.myLocation
        myLocationImageView.contentMode = .scaleAspectFit
        addSubview(myLocationImageView)
        
        NSLayoutConstraint.activate([
            placeImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            placeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            placeImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            placeImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor),
            
            
            myLocationImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myLocationImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            myLocationImageView.widthAnchor.constraint(equalTo: placeImageView.heightAnchor),
            
            placeNameLabel.leadingAnchor.constraint(equalTo: placeImageView.trailingAnchor, constant: 4),
            placeNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            placeNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            placeNameLabel.trailingAnchor.constraint(equalTo: myLocationImageView.leadingAnchor, constant: -4)
            
        ])
    }
    
    @objc func placeNameLabelTapped() {
        delegate?.pushToSearchByPlaceNameScreen()
    }
}
