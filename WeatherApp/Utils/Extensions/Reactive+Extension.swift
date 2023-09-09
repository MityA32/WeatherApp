//
//  Reactive+Extension.swift
//  WeatherApp
//
//  Created by Dmytro Hetman on 09.09.2023.
//

import MapKit
import RxSwift
import RxCocoa

extension Reactive where Base: MKLocalSearchCompleter {
    
    private func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
        guard let returnValue = object as? T else {
            throw RxCocoaError.castingError(object: object, targetType: resultType)
        }
        return returnValue
    }
    
    public var delegate: DelegateProxy<MKLocalSearchCompleter, MKLocalSearchCompleterDelegate> {
        return RxMKLocalSearchCompleterDelegateProxy.proxy(for: base)
    }
    
    public var didUpdateResults: ControlEvent<MKLocalSearchCompleter> {
        let source = delegate
            .methodInvoked(#selector(MKLocalSearchCompleterDelegate.completerDidUpdateResults(_:)))
            .map { a in
                return try castOrThrow(MKLocalSearchCompleter.self, a[0])
            }
        return ControlEvent(events: source)
    }
    
    public var didFailWithError: ControlEvent<Error> {
        let source = delegate
            .methodInvoked(#selector(MKLocalSearchCompleterDelegate.completer(_:didFailWithError:)))
            .map { a in
                return try castOrThrow(Error.self, a[1])
            }
        return ControlEvent(events: source)
    }
    
    public var queryFragment: Binder<String> {
        return Binder(self.base) { localSearchCompleter, query in
            localSearchCompleter.queryFragment = query
        }
    }
}
