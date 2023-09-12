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
import GooglePlaces

final class PlaceNamesProvider: NSObject {
    
    private let disposeBag = DisposeBag()
    let inText = PublishRelay<String>()
    let outSearchResults = PublishRelay<Set<Place>>()
    let completerDidUpdateResultsObservable = PublishSubject<Void>()
    
    private var placesClient: GMSPlacesClient!
    let token = GMSAutocompleteSessionToken.init()
    let filter = GMSAutocompleteFilter()
    
    override init() {
        super.init()
        placesClient = GMSPlacesClient.shared()
        setupRx()
    }
    
    
    private func setupRx() {
        inText
            .flatMapLatest { [unowned self] query -> Observable<Set<Place>> in
                self.getResults(from: query)
                    .catch { error in
                        return Observable.just(Set<Place>())
                    }
            }
            .bind(to: outSearchResults)
            .disposed(by: disposeBag)
    }
    
    func getResults(from query: String) -> Observable<Set<Place>> {
        Observable.create { [weak self] observer in
            self?.placesClient?
                .findAutocompletePredictions(fromQuery: query,
                                            filter: self?.filter,
                                            sessionToken: self?.token,
                                            callback: { (results, error) in
                if let error = error {
                    print("Autocomplete error: \(error.localizedDescription)")
                    observer.onError(error)
                }
                let places = results?
                    .map {
                        Place(city: $0.attributedPrimaryText.string, country: $0.attributedSecondaryText?.string ?? "")
                    }
                observer.onNext(Set(places ?? []))
                observer.onCompleted()
            })
            
            return Disposables.create { }
        }
    }
}






//    func mapItems(for searchRequest: MKLocalSearch) -> Observable<Set<Place>> {
//        Observable.create { observer in
//            searchRequest.start(completionHandler: { (response, error) in
//                print("inrequest")
//                if let error = error {
//                    print(error.localizedDescription)
//                    observer.onError(error)
//                } else {
//                    print("111")
//                    print(response?.mapItems)
//                    let items = response?.mapItems
//                        .compactMap {
//                            Place(city: $0.placemark.locality ?? "", country: $0.placemark.country ?? "")
//                        }
//
//                    observer.onNext(Set(items ?? []))
//                    observer.onCompleted()
//                }
//            })
//
//            return Disposables.create {
//                searchRequest.cancel()
//            }
//        }
//    }




    







