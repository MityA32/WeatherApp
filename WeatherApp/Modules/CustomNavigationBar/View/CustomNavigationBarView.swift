//
//  CustomNavigationBarView.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 04.09.2023.
//

import UIKit

final class CustomNavigationBarView: UIView {
    
    var weatherDetailsNavigationBar: WeatherDetailsNavigationBarView?
    var searchPlaceByTextNavigationBar: SearchPlaceByTextNavigationBarView?
    var searchPlaceByMapNavigationBar: SearchPlaceByMapNavigationBarView?
    
    weak var delegateToSearchByPlaceName: NavigateToSearchByPlaceNameScreenDelegate? {
        didSet {
            weatherDetailsNavigationBar?.delegate = delegateToSearchByPlaceName
        }
    }
    
    weak var delegatePopViewController: PopViewControllerDelegate? {
        didSet {
            searchPlaceByTextNavigationBar?.delegate = delegatePopViewController
        }
    }
    
    weak var delegateDismissViewController: SearchPlaceByMapNavigationBarViewDelegate? {
        didSet {
            searchPlaceByMapNavigationBar?.delegate = delegateDismissViewController
        }
    }
    
    let type: ScreenType
    
    init(type: ScreenType) {
        self.type = type
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "hex_4A90E2")
        switch type {
            case .weatherDetails:
                setupWeatherDetails()
            case .searchPlaceByText:
                setupSearchPlaceByText()
            case .searchPlaceByMap:
                setupSearchPlaceByMap()
        }
    }
    
    private func setupWeatherDetails() {
        weatherDetailsNavigationBar = WeatherDetailsNavigationBarView()
        guard let weatherDetailsNavigationBar else { return }
        addSubview(weatherDetailsNavigationBar)
        
        NSLayoutConstraint.activate([
            weatherDetailsNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherDetailsNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            weatherDetailsNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherDetailsNavigationBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupSearchPlaceByText() {
        searchPlaceByTextNavigationBar = SearchPlaceByTextNavigationBarView()
        guard let searchPlaceByTextNavigationBar else { return }
        addSubview(searchPlaceByTextNavigationBar)
        NSLayoutConstraint.activate([
            searchPlaceByTextNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchPlaceByTextNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            searchPlaceByTextNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchPlaceByTextNavigationBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupSearchPlaceByMap() {
        searchPlaceByMapNavigationBar = SearchPlaceByMapNavigationBarView()
        guard let searchPlaceByMapNavigationBar else { return }
        addSubview(searchPlaceByMapNavigationBar)
        NSLayoutConstraint.activate([
            searchPlaceByMapNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchPlaceByMapNavigationBar.topAnchor.constraint(equalTo: topAnchor),
            searchPlaceByMapNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchPlaceByMapNavigationBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
