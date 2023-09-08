//
//  WeatherDetailsScreenViewController.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 03.09.2023.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class WeatherDetailsScreenViewController: UIViewController {

    private let aboveNavigationBarView = UIView()
    private let customNavigationBarView = CustomNavigationBarView(type: .weatherDetails)
    private let generalDetailsView = WeatherDetailsView()
    private let weatherForecastByDayTableView = UITableView()
    private var weatherTempsByHoursCollectionView: UICollectionView?
    
    private let viewModel = WeatherDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    private let locationService = LocationService()
    
    private var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupLocationServices()
        setupViews()
        setupRx()
    }
}

extension WeatherDetailsScreenViewController {
    private func setupLocationServices() {
        locationService.delegate = self
        locationService.requestLocationAuth()
    }
}

extension WeatherDetailsScreenViewController: LocationServiceDelegate {
    func locationServiceDidUpdateCityName(cityName: String) {
        viewModel.inCity.accept(cityName)
    }
}

private extension WeatherDetailsScreenViewController {
    private func setupViews() {
        setupCustomNavigationNar()
        setupWeatherDetails()
        setupWeatherTempsByHoursCollectionView()
        setupWeatherForecastByDayTableView()
    }
    
    private func setupCustomNavigationNar() {
        aboveNavigationBarView.translatesAutoresizingMaskIntoConstraints = false
        aboveNavigationBarView.backgroundColor = UIColor(named: "hex_4A90E2")
        view.addSubview(aboveNavigationBarView)
        
        view.addSubview(customNavigationBarView)
        
        NSLayoutConstraint.activate([
            aboveNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            aboveNavigationBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboveNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboveNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            customNavigationBarView.topAnchor.constraint(equalTo: aboveNavigationBarView.bottomAnchor),
            customNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBarView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupWeatherDetails() {
        view.addSubview(generalDetailsView)
        
        NSLayoutConstraint.activate([
            generalDetailsView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor),
            generalDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalDetailsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setupWeatherTempsByHoursCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4 - 10, height: view.frame.height * 0.14)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        weatherTempsByHoursCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        guard let collectionView = weatherTempsByHoursCollectionView else { return }
        collectionView.backgroundColor = UIColor(named: "hex_5A9FF0")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeatherTempsByHoursCollectionViewCell.self, forCellWithReuseIdentifier: WeatherTempsByHoursCollectionViewCell.id)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: generalDetailsView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
    }
    
    
    private func setupWeatherForecastByDayTableView() {
        weatherForecastByDayTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastByDayTableView.register(WeatherForecastByDayTableViewCell.self, forCellReuseIdentifier: WeatherForecastByDayTableViewCell.id)
        weatherForecastByDayTableView.backgroundColor = UIColor(named: "hex_FFFFFF")
        weatherForecastByDayTableView.separatorStyle = .none
        
        view.addSubview(weatherForecastByDayTableView)
        guard let weatherTempsByHoursCollectionView else { return }
        NSLayoutConstraint.activate([
            weatherForecastByDayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherForecastByDayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherForecastByDayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherForecastByDayTableView.topAnchor.constraint(equalTo: weatherTempsByHoursCollectionView.bottomAnchor)
        ])
    }
}


private extension WeatherDetailsScreenViewController {
    
    private func setupRx() {
        guard let bar = customNavigationBarView.weatherDetailsNavigationBar else { return }
        viewModel.inCity
            .bind(to: bar.placeNameLabel.rx.text)
            .disposed(by: disposeBag)
        weatherForecastByDayTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.outWeather
            .bind(to: weatherForecastByDayTableView.rx.items(cellIdentifier: WeatherForecastByDayTableViewCell.id, cellType: WeatherForecastByDayTableViewCell.self)) { [weak self] index, model, cell in
                guard let self else { return }
                cell.config(from: model.value)
                let isSelected = index == self.selectedIndexPath?.row
                cell.setSelected(isSelected, animated: false)
            }
            .disposed(by: disposeBag)
        weatherForecastByDayTableView.rx
            .itemSelected
            .map { $0.row }
            .bind(to: viewModel.inSelectedIndexOfDay)
            .disposed(by: disposeBag)
        viewModel.outWeatherForecastBySelectedDay
            .bind(onNext: { [weak self] weatherData in
                self?.generalDetailsView.config(from: weatherData)
            })
            .disposed(by: disposeBag)
        guard let weatherTempsByHoursCollectionView else { return }
        viewModel.outWeatherForecastBySelectedDay
            .bind(to: weatherTempsByHoursCollectionView.rx.items(cellIdentifier: WeatherTempsByHoursCollectionViewCell.id, cellType: WeatherTempsByHoursCollectionViewCell.self)) { index, model, cell in
                cell.config(from: model)
            }
            .disposed(by: disposeBag)
    }
}

extension WeatherDetailsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.none)
            viewModel.inSelectedIndexOfDay.accept(0)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
