//
//  SearchByPlaceNameScreenViewModel.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

final class SearchByPlaceNameScreenViewModel {
    
    private let placesProvider = PlaceNamesProvider()
    private let disposeBag = DisposeBag()
    let inPlaceName = PublishRelay<String>()
    private let _outPlaceVariants = PublishRelay<Set<Place>>()
    private(set) lazy var outPlaceVariants = _outPlaceVariants.asObservable()
    
    
    init() {
        setupRx()
    }
    
    deinit {
        print("deinit vm")
    }
    
    private func setupRx() {
        inPlaceName
            .bind(to: placesProvider.inText)
            .disposed(by: disposeBag)
        placesProvider.outSearchResults
            .bind(to: _outPlaceVariants)
            .disposed(by: disposeBag)
    }
}
