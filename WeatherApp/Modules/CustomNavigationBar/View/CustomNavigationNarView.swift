//
//  CustomNavigationNarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 04.09.2023.
//

import UIKit

class CustomNavigationNarView: UIView {
    
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemPink
    }
    
}
