//
//  CommentsContentManagerImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentsContentManager

class PostListModel: Hashable {
    
    let identifier = UUID()
    
    init() {
        
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: PostListModel, rhs: PostListModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class MediaImageCellModel: PostListModel {
    
    let media: MediaPlainObject
    
    init(media: MediaPlainObject) {
        self.media = media
        super.init()
    }
}

class PagerCellModel: PostListModel {
    
    let post: PostPlainObject
    
    init(post: PostPlainObject) {
        self.post = post
        super.init()
    }
}

class PostAuthorCellModel: PostListModel {
    
    let post: PostPlainObject
    
    init(post: PostPlainObject) {
        self.post = post
        super.init()
    }
}

class PostRequestCellModel: PostListModel {
    
    let post: PostPlainObject
    
    init(post: PostPlainObject) {
        self.post = post
        super.init()
    }
}

class PostTotalCommentsCellModel: PostListModel {
    
    let post: PostPlainObject
    
    init(post: PostPlainObject) {
        self.post = post
        super.init()
    }
}

class PostCommentComposeCellModel: PostListModel {
    
}

class CommentCellModel: PostListModel {
    
    let comment: CommentPlainObject
    
    init(comment: CommentPlainObject) {
        self.comment = comment
        super.init()
    }
}

class CommentsContentManagerImplementation: NSObject, CommentsContentManager {
    
    var collectionView: UICollectionView?
    
//    weak var delegate: MainContentManagerImplementationDelegate?
    
    // MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Int, PostListModel>?
    
    /// Current controllers which manipulates tableView's cells
    fileprivate var controllers: [TableCellController] = []
    
    // MARK: - Initializers
    
    /// Default initializer
    ///
    override init() {
        super.init()
    }
    
    // MARK: - ContentManager
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [unowned self] (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            
            let galleryItem = NSCollectionLayoutItem(layoutSize:
                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                       heightDimension: .fractionalHeight(1.0)))
            galleryItem.contentInsets = .zero //.init(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .fractionalHeight(1.0)))
            
            var sections = 0
            if let collectionView = self.collectionView, let numberOfSections: Int = self.dataSource?.numberOfSections(in: collectionView) {
                sections = numberOfSections
            }

            if sectionIndex == 0 {
                let screenHeight = UIScreen.main.bounds.height
                let absoluteHeight = screenHeight * 550.0 / 815.0
                
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                        heightDimension: .absolute(absoluteHeight))
                let galleryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,subitem: galleryItem, count: 1)
                let gallerySection = NSCollectionLayoutSection(group: galleryGroup)
                gallerySection.orthogonalScrollingBehavior = .groupPaging
                return gallerySection
            } else if sectionIndex == 1 || sectionIndex == 2 {
                let plainGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(36)),
                                                                    subitem: headerItem,
                                                                    count: 1)
                return NSCollectionLayoutSection(group: plainGroup)
            } else if sectionIndex == sections - 1 {
                let plainGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(78)),
                                                                    subitem: headerItem,
                                                                    count: 1)
                return NSCollectionLayoutSection(group: plainGroup)
            } else {
                let plainGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                           heightDimension: .absolute(44)),
                                                                    subitem: headerItem,
                                                                    count: 1)
                return NSCollectionLayoutSection(group: plainGroup)
            }
        }
        return layout
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else {
            return
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, PostListModel>(collectionView: collectionView) { [unowned self]
            (collectionView: UICollectionView, indexPath: IndexPath, model: PostListModel) -> UICollectionViewCell? in
            
            if let imageCellModel = model as? MediaImageCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostMediaImageCell.identifier, for: indexPath) as? PostMediaImageCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: imageCellModel)
                return cell
            } else if let authorCellModel = model as? PostAuthorCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostAuthorCell.identifier, for: indexPath) as? PostAuthorCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: authorCellModel)
                return cell
            } else if let requestCellModel = model as? PostRequestCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostRequestCell.identifier, for: indexPath) as? PostRequestCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: requestCellModel)
                return cell
            } else if let commentCellModel = model as? CommentCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCommentCell.identifier, for: indexPath) as? PostCommentCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: commentCellModel)
                return cell
            } else if let totalCommentsModel = model as? PostTotalCommentsCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostTotalCommentsCell.identifier, for: indexPath) as? PostTotalCommentsCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: totalCommentsModel)
                return cell
            } else if let composeModel = model as? PostCommentComposeCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostComposeCommentCell.identifier, for: indexPath) as? PostComposeCommentCell else { fatalError("Could not create new cell") }
                return cell
            } else {
                fatalError()
            }
        }
        
        func produceImage() -> UIImage {
            return UIImage()
        }
    }
    
    func configure(withCollectionView collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.collectionView?.register(PostMediaImageCell.self, forCellWithReuseIdentifier: PostMediaImageCell.identifier)
        self.collectionView?.register(PostAuthorCell.self, forCellWithReuseIdentifier: PostAuthorCell.identifier)
        self.collectionView?.register(PostRequestCell.self, forCellWithReuseIdentifier: PostRequestCell.identifier)
        self.collectionView?.register(PostCommentCell.self, forCellWithReuseIdentifier: PostCommentCell.identifier)
        self.collectionView?.register(PostTotalCommentsCell.self, forCellWithReuseIdentifier: PostTotalCommentsCell.identifier)
        self.collectionView?.register(PostComposeCommentCell.self, forCellWithReuseIdentifier: PostComposeCommentCell.identifier)
        configureDataSource()
        self.collectionView?.delegate = self
    }
    
    func updateData(_ post: PostPlainObject) {
        guard let dataSource = dataSource else {
            return
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, PostListModel>()
        var section = 0
        // Pages
        snapshot.appendSections([ section ])
        snapshot.appendItems( post.mediaList.map { MediaImageCellModel(media: $0) } )
        
        // Pager
//        section += 1
//        snapshot.appendSections([ section ])
//        snapshot.appendItems( [ PagerCellModel(post: post) ] )
        
        // Author
        section += 1
        snapshot.appendSections([ section ])
        snapshot.appendItems( [ PostAuthorCellModel(post: post) ] )
        
        // Request
        section += 1
        snapshot.appendSections([ section ])
        snapshot.appendItems( [ PostRequestCellModel(post: post) ] )
        
        section += 1
        snapshot.appendSections([ section ])
        snapshot.appendItems( [ PostTotalCommentsCellModel(post: post) ] )
        
        section += 1
        snapshot.appendSections([ section ])
        snapshot.appendItems( [ PostCommentComposeCellModel() ] )
        
        // Comments
//        snapshot.appendSections([ 3 ])
//        viewModels.enumerated().forEach { offset, model in
//            snapshot.appendSections([ 1 + offset * 2 ])
//            snapshot.appendItems([ HeaderCellModel(post: model.headerViewModel.post) ])
//
//            snapshot.appendSections([ 1 + offset * 2 + 1 ])
//            let models = model.viewModels.map { ImageCellModel(post: $0.post, media: $0.media) }
//            snapshot.appendItems(models)
//        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func updateData(_ comments: [CommentCellViewModelProtocol]) {
        if let snapshot = dataSource?.snapshot(), let lastSectionIdentifier = snapshot.sectionIdentifiers.last {
            var snapshotMutable = snapshot
            snapshotMutable.appendItems(comments.map { CommentCellModel(comment: $0.comment) },
                                        toSection: lastSectionIdentifier)
//            snapshotMutable.appendSections([ lastSectionIdentifier + 1 ])
//            snapshotMutable.appendItems( comments.map { CommentCellModel(comment: $0.comment) } )
            dataSource?.apply(snapshotMutable, animatingDifferences: false)
        }
    }
}

// MARK: - UITableViewDelegate

extension CommentsContentManagerImplementation: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if let item = dataSource?.itemIdentifier(for: indexPath), let post = item.post {
//            delegate?.didPostSelect(post)
//        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < -64 {
            scrollView.contentOffset.y = -64
        }
    }
    
}


// MARK: - UITableViewDelegate

extension CommentsContentManagerImplementation: UITableViewDelegate {
    
    
}

// MARK: - UITableViewDataSource

extension CommentsContentManagerImplementation: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = controllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
        return cell
    }
}
