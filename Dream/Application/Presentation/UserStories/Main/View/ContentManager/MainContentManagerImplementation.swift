//
//  MainContentManagerImplementation.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit
import DiffableDataSources

// MARK: - MainContentManager

class GoodieListModel: Hashable {
    
    let post: PostPlainObject?
    let identifier = UUID()
    
    init(post: PostPlainObject?) {
        self.post = post
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: GoodieListModel, rhs: GoodieListModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

class ImageCellModel: GoodieListModel {
    
    let media: MediaPlainObject
    
    init(post: PostPlainObject, media: MediaPlainObject) {
        self.media = media
        super.init(post: post)
    }
}

class NewRequestCellModel: GoodieListModel {
    init() {
        super.init(post: nil)
    }
}

class HeaderCellModel: GoodieListModel {
    
    override init(post: PostPlainObject?) {
        super.init(post: post)
    }
}

struct GoodieCellModel {
    
    let headerViewModel: GoodieHeaderCellViewModelProtocol
    let viewModels: [GoodieCellViewModelProtocol]
    
}

protocol MainContentManagerImplementationDelegate: class {
    
    func didPostSelect(_ post: PostPlainObject)
    
}

class MainContentManagerImplementation: NSObject, MainContentManager {
    
    var collectionView: UICollectionView?
    
    weak var delegate: MainContentManagerImplementationDelegate?
    
    // MARK: - Properties
    private var dataSource: UICollectionViewDiffableDataSource<Int, GoodieListModel>?
    
    /// Card controllers factory
    fileprivate let controllersFactory: CardCellControllerFactory
    
    /// Current controllers which manipulates tableView's cells
    fileprivate var controllers: [TableCellController] = []
    
    // MARK: - Initializers

    /// Default initializer
    ///
    /// - Parameter controllersFactory: card controllers factory
    init(controllersFactory: CardCellControllerFactory) {
        self.controllersFactory = controllersFactory
        super.init()
    }

    // MARK: - ContentManager
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            
            let galleryItem = NSCollectionLayoutItem(layoutSize:
                NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                       heightDimension: .fractionalHeight(1.0)))
            galleryItem.contentInsets = .zero //.init(top: 8, leading: 8, bottom: 8, trailing: 8)
            
            let headerItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .fractionalHeight(1.0)))

            if sectionIndex == 0 {
                let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(310)),
                                                                     subitem: headerItem, count: 1)
                return NSCollectionLayoutSection(group: headerGroup)
            } else if (sectionIndex - 1) % 2 != 0 {
                let widthFraction: CGFloat = 0.4
                // 271 - figma height
                // 174 - figma width
                let absoluteWidth = UIScreen.main.bounds.width * widthFraction
                let absoluteHeight = absoluteWidth * CGFloat(271) / CGFloat(174)
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
                                                        heightDimension: .absolute(absoluteHeight))
                let galleryGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutSize,subitem: galleryItem, count: 1)
                let gallerySection = NSCollectionLayoutSection(group: galleryGroup)
                gallerySection.contentInsets.leading = 14
                gallerySection.contentInsets.trailing = 14
                gallerySection.contentInsets.bottom = 24
                gallerySection.contentInsets.top = 16
                gallerySection.orthogonalScrollingBehavior = .groupPaging
                return gallerySection
            } else {
                let headerGroup = NSCollectionLayoutGroup.horizontal(layoutSize:
                    NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44)),
                                                                     subitem: headerItem, count: 1)
                return NSCollectionLayoutSection(group: headerGroup)
            }
        }
        return layout
    }
    
    private func configureDataSource() {
        guard let collectionView = collectionView else {
            return
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, GoodieListModel>(collectionView: collectionView) { [unowned self]
            (collectionView: UICollectionView, indexPath: IndexPath, model: GoodieListModel) -> UICollectionViewCell? in
            
            if let headerModel = model as? HeaderCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodieHeaderCell.identifier, for: indexPath) as? GoodieHeaderCell else { fatalError("Could not create new cell") }
                cell.setup(withModel: headerModel)
                return cell
            } else if let imageModel = model as? ImageCellModel {
                guard let numberOfItems = self.dataSource?.collectionView(collectionView,
                                                                          numberOfItemsInSection: indexPath.section) else {
                    fatalError()
                }
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodieCell.identifier, for: indexPath) as? GoodieCell else { fatalError("Could not create new cell") }
                
                cell.clipsToBounds = true
                cell.setup(withModel: imageModel, isFirst: indexPath.row == 0, isLast: indexPath.row == numberOfItems - 1)
                return cell
            } else if let newRequestModel = model as? NewRequestCellModel {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewRequestCell.identifier, for: indexPath) as? NewRequestCell else { fatalError("Could not create new cell") }
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
        self.collectionView?.register(GoodieCell.self, forCellWithReuseIdentifier: GoodieCell.identifier)
        self.collectionView?.register(GoodieHeaderCell.self, forCellWithReuseIdentifier: GoodieHeaderCell.identifier)
        self.collectionView?.register(NewRequestCell.self, forCellWithReuseIdentifier: NewRequestCell.identifier)
        configureDataSource()
        self.collectionView?.delegate = self
    }

    func updateData(_ viewModels: [GoodieCellModel]) {
        guard let dataSource = dataSource else {
            return
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, GoodieListModel>()
        snapshot.appendSections([ 0 ])
        snapshot.appendItems([ NewRequestCellModel() ])
        viewModels.enumerated().forEach { offset, model in
            snapshot.appendSections([ 1 + offset * 2 ])
            snapshot.appendItems([ HeaderCellModel(post: model.headerViewModel.post) ])
            
            snapshot.appendSections([ 1 + offset * 2 + 1 ])
            let models = model.viewModels.map { ImageCellModel(post: $0.post, media: $0.media) }
            snapshot.appendItems(models)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


// MARK: - UITableViewDelegate

extension MainContentManagerImplementation: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = dataSource?.itemIdentifier(for: indexPath), let post = item.post {
            delegate?.didPostSelect(post)
        }
    }
    
}


// MARK: - UITableViewDelegate

extension MainContentManagerImplementation: UITableViewDelegate {
    
    
}

// MARK: - UITableViewDataSource

extension MainContentManagerImplementation: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = controllers[indexPath.row].cellFromReusableCellHolder(tableView, forIndexPath: indexPath)
        return cell
    }
}
