//
//  SearchPlaceByMapNavigationBarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 08.09.2023.
//

import UIKit

final class SearchPlaceByMapNavigationBarView: UIView {

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
    }
    
    func setupViews() {
        
    }

}
