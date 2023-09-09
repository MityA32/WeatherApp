//
//  RxMKLocalSearchCompleterDelegateProxy.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import MapKit
import RxCocoa

final class RxMKLocalSearchCompleterDelegateProxy: DelegateProxy<MKLocalSearchCompleter, MKLocalSearchCompleterDelegate>, DelegateProxyType, MKLocalSearchCompleterDelegate {
    static func currentDelegate(for object: MKLocalSearchCompleter) -> MKLocalSearchCompleterDelegate? {
        object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: MKLocalSearchCompleterDelegate?, to object: MKLocalSearchCompleter) {
        object.delegate = delegate
    }
    
    public weak private(set) var localSearchCompleter: MKLocalSearchCompleter?
    public init(localSearchCompleter: ParentObject) {
        self.localSearchCompleter = localSearchCompleter
        super.init(parentObject: localSearchCompleter,
                    delegateProxy: RxMKLocalSearchCompleterDelegateProxy.self)
    }
    static func registerKnownImplementations() {
        self.register { RxMKLocalSearchCompleterDelegateProxy(localSearchCompleter:$0)}
    }
}
