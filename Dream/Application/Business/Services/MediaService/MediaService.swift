//
//  MediaService.swift
//  Dream
//
//  Created by denis on 14.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import RxSwift

protocol MediaService {
    
    func obtainMediaDetails(forMediaId id: String) -> Observable<MediaDetailsPlainObject?>
    
    func sendMedia(withData data: Data, andBrand brand: String) -> Observable<MediaDetailsPlainObject?>
    
}
