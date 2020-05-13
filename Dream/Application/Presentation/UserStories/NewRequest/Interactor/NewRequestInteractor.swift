//
//  NewRequestInteractor.swift
//  Dream
//
//  Created by Denis Maltsev on 06/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - NewRequestInteractor

class NewRequestInteractor {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    private let userService: UserService
    
    private let mediaService: MediaService
    
    private let postService: PostService
    
    /// Presenter instance
    weak var output: NewRequestInteractorOutput?
    
    init(userService: UserService, mediaService: MediaService, postService: PostService) {
        self.userService = userService
        self.mediaService = mediaService
        self.postService = postService
    }
}

// MARK: - NewRequestInteractorInput

extension NewRequestInteractor: NewRequestInteractorInput {
    
    func createPost(name: String, age: Int, description: String, media: [UIImage]) {
        let createMediaObservables = media.compactMap { $0.jpegData(compressionQuality: 0.99) }.map { mediaService.sendMedia(withData: $0, andBrand: "") }
        Observable<MediaDetailsPlainObject?>.zip(createMediaObservables)
            .flatMap { [unowned self] mediaList in
                self.postService.addPost(description: description, mediaIds: mediaList.compactMap { $0?.id })
            }.subscribe().disposed(by: disposeBag)
    }
    
}
