//
//  SearchPlaceByMapNavigationBarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import UIKit

final class SearchPlaceByMapNavigationBarView: UIView {

    private let leadingButton = UIButton()
    private let label = UILabel()
    private let trailingButton = UIButton()
    
    weak var delegate: SearchPlaceByMapNavigationBarViewDelegate?
    
    init() {
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
        setupLeadingButton()
        setupTrailingButton()
        setupLabel()
    }

    private func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select a city"
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingButton.leadingAnchor, constant: -10),
            label.leadingAnchor.constraint(equalTo: leadingButton.trailingAnchor, constant: 10)
        ])
    }
    
    private func setupLeadingButton() {
        leadingButton.translatesAutoresizingMaskIntoConstraints = false
        leadingButton.setTitle("Cancel", for: .normal)
        leadingButton.addTarget(self, action: #selector(onBackTapped), for: .touchUpInside)
        addSubview(leadingButton)
        
        NSLayoutConstraint.activate([
            leadingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            leadingButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            leadingButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            leadingButton.widthAnchor.constraint(equalTo: leadingButton.heightAnchor, multiplier: 3)
        ])
    }
    
    private func setupTrailingButton() {
        trailingButton.translatesAutoresizingMaskIntoConstraints = false
        trailingButton.setTitle("Done", for: .normal)
        trailingButton.addTarget(self, action: #selector(onDoneTapped), for: .touchUpInside)
        addSubview(trailingButton)
        
        NSLayoutConstraint.activate([
            trailingButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            trailingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            trailingButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            trailingButton.widthAnchor.constraint(equalTo: trailingButton.heightAnchor, multiplier: 3)
        ])
    }
    
    @objc
    private func onDoneTapped() {
        delegate?.tapOnDoneButton()
    }
    
    @objc
    private func onBackTapped() {
        delegate?.tapOnBackButton()
    }
}
