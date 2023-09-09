//
//  PlaceNamesProvider.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import Foundation
import MapKit
import RxSwift
import RxRelay
import RxCocoa

final class PlaceNamesProvider: NSObject {
    
    private let disposeBag = DisposeBag()
    let inText = PublishRelay<String>()
    let outSearchResults = PublishRelay<[Place]>()
    let completerDidUpdateResultsObservable = PublishSubject<Void>()
    var searchCompleter = MKLocalSearchCompleter()
    
    var searchResults = [MKLocalSearchCompletion]()
    
    override init() {
        super.init()
        setupRx()
    }
    
    private func setupRx() {
        inText
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .bind(to: searchCompleter.rx.queryFragment)
            .disposed(by: disposeBag)
        
        searchCompleter.rx.didUpdateResults
            .map { completer in
                completer.results.map {
                    Place(city: $0.title, country: $0.subtitle)
                }
            }
            .bind(to: outSearchResults)
            .disposed(by: disposeBag)
        
    }
    
    
}






