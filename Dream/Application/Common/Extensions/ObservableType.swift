//
//  ObservableType.swift
//  Dream
//
//  Created by denis on 15.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

extension ObservableType {

    /**
     Takes a sequence of optional elements and returns a sequence of non-optional elements, filtering out any nil values.
     - returns: An observable sequence of non-optional elements
     */
    public func filterNil<T>() -> Observable<T> where E == Optional<T> {
        //swiftlint:disable:previous syntactic_sugar
        return self
            .flatMap { value -> Observable<T> in
                if let value = value {
                    return .just(value)
                }

                return .empty()
            }
    }
}
