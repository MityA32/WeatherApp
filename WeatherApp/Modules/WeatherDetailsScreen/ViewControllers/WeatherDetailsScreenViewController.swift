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

final class WeatherDetailsScreenViewController: UIViewController {

    private let aboveNavigationBarView = UIView()
    private let customNavigationBarView = CustomNavigationBarView(type: .weatherDetails)
    private let generalDetailsView = WeatherDetailsView()
    private let weatherForecastByDayTableView = UITableView()
    private var weatherTempsByHoursCollectionView: UICollectionView?
    private var collectionViewLayoutForReuse: UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (weatherTempsByHoursCollectionView?.frame.width ?? 40) / 5, height: (weatherTempsByHoursCollectionView?.frame.height ?? 40))
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        return flowLayout
    }
    
    private let viewModel = WeatherDetailsViewModel()
    private let disposeBag = DisposeBag()
    
    private let locationService = LocationService()
    private var commonConstraints: [NSLayoutConstraint] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupLocationServices()
        setupViews()
        commonConstraints = setupedConstraints(isVertical: true)
        NSLayoutConstraint.activate(commonConstraints)
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

extension WeatherDetailsScreenViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { [weak self] _ in
            guard let self else { return }
            let isVertical = self.traitCollection.verticalSizeClass == .compact
            self.updateConstraintsForSizeClass(isVertical: isVertical)
            self.view.layoutIfNeeded()
            weatherTempsByHoursCollectionView?.collectionViewLayout = self.collectionViewLayoutForReuse
        }, completion: nil)
    }

    private func updateConstraintsForSizeClass(isVertical: Bool) {
        NSLayoutConstraint.deactivate(commonConstraints)
        if isVertical {
            commonConstraints = setupedConstraints(isVertical: false)
            
        } else {
            commonConstraints = setupedConstraints(isVertical: true)
        }

        NSLayoutConstraint.activate(commonConstraints)
    }
    
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
        
        customNavigationBarView.delegateToSearchByPlaceName = self
        view.addSubview(customNavigationBarView)
    }
    
    private func setupWeatherDetails() {
        view.addSubview(generalDetailsView)
    }
    
    private func setupWeatherTempsByHoursCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 4 - 10, height: view.frame.height * 0.14)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.0
        weatherTempsByHoursCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        weatherTempsByHoursCollectionView?.backgroundColor = UIColor(named: "hex_5A9FF0")
        weatherTempsByHoursCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        weatherTempsByHoursCollectionView?.showsHorizontalScrollIndicator = false
        weatherTempsByHoursCollectionView?.register(WeatherTempsByHoursCollectionViewCell.self, forCellWithReuseIdentifier: WeatherTempsByHoursCollectionViewCell.id)
        
        guard let weatherTempsByHoursCollectionView else { return }
        weatherTempsByHoursCollectionView.layoutIfNeeded()
        view.addSubview(weatherTempsByHoursCollectionView)
    }
    
    
    private func setupWeatherForecastByDayTableView() {
        weatherForecastByDayTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastByDayTableView.register(WeatherForecastByDayTableViewCell.self, forCellReuseIdentifier: WeatherForecastByDayTableViewCell.id)
        weatherForecastByDayTableView.separatorStyle = .none
        weatherForecastByDayTableView.backgroundColor = .white
        weatherForecastByDayTableView.rowHeight = UITableView.automaticDimension
        view.addSubview(weatherForecastByDayTableView)
    }
    
    private func setupedConstraints(isVertical: Bool) -> [NSLayoutConstraint] {
        guard let collectionView = weatherTempsByHoursCollectionView else { return [] }
       return [
            aboveNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            aboveNavigationBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboveNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboveNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            customNavigationBarView.topAnchor.constraint(equalTo: isVertical ? aboveNavigationBarView.bottomAnchor : view.safeAreaLayoutGuide.topAnchor),
            customNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBarView.heightAnchor.constraint(equalToConstant: 44),

            generalDetailsView.topAnchor.constraint(equalTo: customNavigationBarView.bottomAnchor),
            generalDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generalDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generalDetailsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: isVertical ? 0.3 : 0.35),

            collectionView.topAnchor.constraint(equalTo: generalDetailsView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: isVertical ? 0.15 : 0.3),
        
            weatherForecastByDayTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherForecastByDayTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherForecastByDayTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            weatherForecastByDayTableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor)
        ]
    }
}


private extension WeatherDetailsScreenViewController {
    
    private func setupRx() {
        guard let bar = customNavigationBarView.weatherDetailsNavigationBar else { return }
        viewModel.inCity
            .bind(to: bar.placeNameLabel.rx.text)
            .disposed(by: disposeBag)


        viewModel.outWeather
            .bind(to: weatherForecastByDayTableView.rx.items(
                cellIdentifier: WeatherForecastByDayTableViewCell.id,
                cellType: WeatherForecastByDayTableViewCell.self)) { index, model, cell in
                cell.config(from: model.value)
            }
            .disposed(by: disposeBag)
    
        weatherForecastByDayTableView.rx.willDisplayCell
            .compactMap { [weak self] cell, indexPath in
                if self?.weatherForecastByDayTableView.indexPathsForSelectedRows == nil, indexPath.row == 0 {
                    self?.weatherForecastByDayTableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
                    return 0
                }
                return nil
            }
            .bind(to: viewModel.inSelectedIndexOfDay)
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

extension WeatherDetailsScreenViewController: NavigateToSearchByPlaceNameScreenDelegate {
    func presentSearchByMapScreen() {
        let searchByMapViewController = SearchByMapScreenViewController()
        searchByMapViewController.onSelectCity
            .do(onNext: { _ in
                searchByMapViewController.dismiss(animated: true)
            })
            .bind(to: viewModel.inCity)
            .disposed(by: searchByMapViewController.disposeBag)
        navigationController?.present(searchByMapViewController, animated: true)
    }
    
    func pushToSearchByPlaceNameScreen() {
        let searchByPlaceNameViewController = SearchByPlaceNameScreenViewController()
        searchByPlaceNameViewController.onSelectCity
            .do(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .bind(to: viewModel.inCity)
                .disposed(by: searchByPlaceNameViewController.disposeBag)
        navigationController?.pushViewController(searchByPlaceNameViewController, animated: true)
    }
}
