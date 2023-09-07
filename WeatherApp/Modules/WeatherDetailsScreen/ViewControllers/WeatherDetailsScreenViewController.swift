//
//  WeatherDetailsScreenViewController.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 03.09.2023.
//

import UIKit
import RxSwift
import RxCocoa


class WeatherDetailsScreenViewController: UIViewController {

    private let aboveNavigationBarView = UIView()
    private let customNavigationBarView = CustomNavigationNarView()
    private let generalDetailsView = WeatherDetailsView()
    private let weatherForecastByDayTableView = UITableView()
    private var weatherTempsByHoursCollectionView: UICollectionView?
    
    private let viewModel = WeatherDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    var selectedIndexPaths = Set<IndexPath>()
    private let selectedWeatherData = BehaviorRelay<[Weather]?>(value: nil)

    
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
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        weatherTempsByHoursCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        guard let collectionView = weatherTempsByHoursCollectionView else { return }
        collectionView.backgroundColor = UIColor(named: "hex_5A9FF0")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: generalDetailsView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
    
    
    private func setupWeatherForecastByDayTableView() {
        weatherForecastByDayTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastByDayTableView.register(WeatherForecastByDayTableViewCell.self, forCellReuseIdentifier: WeatherForecastByDayTableViewCell.id)
        weatherForecastByDayTableView.backgroundColor = UIColor(named: "hex_FFFFFF")
        weatherForecastByDayTableView.separatorStyle = .none
//        weatherForecastByDayTableView.rowHeight = UITableView.automaticDimension
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
        weatherForecastByDayTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        viewModel.outWeather
            .bind(to: weatherForecastByDayTableView.rx.items(cellIdentifier: WeatherForecastByDayTableViewCell.id, cellType: WeatherForecastByDayTableViewCell.self)) { index, model, cell in
                cell.config(from: model.value)
            }
            .disposed(by: disposeBag)
        
//        selectedWeatherData
//               .asObservable()
//               .subscribe(onNext: { [weak self] selectedWeather in
//                   // Check if the selectedWeather is not nil
//                   if let value = selectedWeather {
//                       self?.generalDetailsView.config(from: value)
//                   }
//               })
//               .disposed(by: disposeBag)
    }
}

extension WeatherDetailsScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                let indexPathToDeselect = IndexPath(row: row, section: section)
                if indexPathToDeselect != indexPath {
                    guard let cell = tableView.cellForRow(at: indexPathToDeselect) as? WeatherForecastByDayTableViewCell else {
                        return
                    }
                    cell.setSelected(false, animated: true, shadowColor: nil)

                }
            }
        }
        selectedIndexPaths = []
        selectedIndexPaths.insert(indexPath)

        // Update the cell's appearance
        if let cell = tableView.cellForRow(at: indexPath) as? WeatherForecastByDayTableViewCell {
            cell.setSelected(true, animated: true, shadowColor: UIColor(named: "hex_5A9FF0"))
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
