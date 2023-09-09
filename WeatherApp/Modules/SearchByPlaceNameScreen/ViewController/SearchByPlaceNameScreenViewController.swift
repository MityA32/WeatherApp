//
//  SearchByPlaceNameScreenViewController.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import UIKit
import RxSwift
import RxRelay

final class SearchByPlaceNameScreenViewController: UIViewController {

    private let aboveNavigationBarView = UIView()
    private let customNavigationBar = CustomNavigationBarView(type: .searchPlaceByText)
    private let searchResultsTableView = UITableView()
    
    private let viewModel = SearchByPlaceNameScreenViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViews()
        setupRx()
    }
    
    private func setupViews() {
        setupAboveNavigationBarView()
        setupCustomNavigationNar()
        setupSearchResultsTableView()
    }
    
    private func setupAboveNavigationBarView() {
        aboveNavigationBarView.translatesAutoresizingMaskIntoConstraints = false
        aboveNavigationBarView.backgroundColor = UIColor(named: "hex_4A90E2")
        view.addSubview(aboveNavigationBarView)
        
        NSLayoutConstraint.activate([
            aboveNavigationBarView.topAnchor.constraint(equalTo: view.topAnchor),
            aboveNavigationBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            aboveNavigationBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aboveNavigationBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCustomNavigationNar() {
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        customNavigationBar.delegatePopViewController = self
        view.addSubview(customNavigationBar)
        
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupSearchResultsTableView() {
        searchResultsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchResultsTableView)
        
        NSLayoutConstraint.activate([
            searchResultsTableView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            searchResultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            searchResultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

extension SearchByPlaceNameScreenViewController {
    private func setupRx() {
        guard let navBar = customNavigationBar.searchPlaceByTextNavigationBar else { return }
        navBar.textField.rx.text
            .orEmpty
            .bind(to: viewModel.inPlaceName)
            .disposed(by: disposeBag)
    }
}

extension SearchByPlaceNameScreenViewController: PopViewControllerDelegate {
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
