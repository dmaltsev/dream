//
//  MediaBrandModule.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MediaBrandModule

class MediaBrandModule: Module {

    typealias Input = MediaBrandModuleInput

    required init() {

    }

    static func instantiateTransitionHandler() -> UIViewController {
		return MediaBrandModuleAssembly().obtainViewController()
    }
}