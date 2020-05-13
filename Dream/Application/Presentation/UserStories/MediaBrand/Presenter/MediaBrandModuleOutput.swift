//
//  MediaBrandModuleOutput.swift
//  Dream
//
//  Created by denis on 22.03.2020.
//  Copyright © 2020 Unknown. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MediaBrandModuleOutput

protocol MediaBrandModuleOutput: ModuleOutput {
    
    func setBrand(_ brand: String, withImage image: UIImage?)
    
}

