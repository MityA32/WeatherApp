//
//  WeatherDetailsScreenViewController.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 03.09.2023.
//

import UIKit
import RxSwift


class WeatherDetailsScreenViewController: UIViewController {

    private let generalDetails = WeatherDetailsView()
    private let weatherForecastByDayTableView = UITableView()
    
    private let viewModel = WeatherDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        setupRx()
    }
}

private extension WeatherDetailsScreenViewController {
    private func setupViews() {
        setupWeatherDetails()
        setupWeatherForecastByDayTableView()
    }
    
    private func setupWeatherDetails() {
        view.addSubview(generalDetails)
        
        NSLayoutConstraint.activate([
            generalDetails.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            generalDetails.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalDetails.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalDetails.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupWeatherForecastByDayTableView() {
        weatherForecastByDayTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastByDayTableView.register(WeatherForecastByDayTableViewCell.self, forCellReuseIdentifier: WeatherForecastByDayTableViewCell.id)
        view.addSubview(weatherForecastByDayTableView)
        
        NSLayoutConstraint.activate([
            weatherForecastByDayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherForecastByDayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherForecastByDayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherForecastByDayTableView.topAnchor.constraint(equalTo: generalDetails.bottomAnchor)
        ])
        
        
    }
}


private extension WeatherDetailsScreenViewController {
    private func setupRx() {
        viewModel.outWeather
            .bind(to: weatherForecastByDayTableView.rx.items(cellIdentifier: WeatherForecastByDayTableViewCell.id, cellType: WeatherForecastByDayTableViewCell.self)) { index, model, cell in
                cell.config(from: model.value)
                
            }
            .disposed(by: disposeBag)
    }
}
