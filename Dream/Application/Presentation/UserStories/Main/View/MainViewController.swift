//
//  MainViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 23/10/2019.
//  Copyright © 2019 Мечтару. All rights reserved.
//

import UIKit
import SideMenu

// MARK: - MainViewController

enum MainSection {
    case ItemHeader
    case ItemImages
}

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    /// CollectionView with Card cells
    fileprivate var collectionView: UICollectionView?

    /// Presenter instance
    var output: MainViewOutput?

    /// Main content manager
    var contentManager: MainContentManager?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
    }

    // MARK: - Private

    /// Cards table view setup
    fileprivate func setupCollectionView() {
        guard let layout = contentManager?.collectionViewLayout() else {
            return
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        collectionView?.refreshControl = refreshControl
        
        collectionView?.backgroundColor = .white
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView.prepareForAutolayout())
        collectionView.pinToSuperview(withOffset: 0)
        contentManager?.configure(withCollectionView: collectionView)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "NavHamburger"), style: .plain, target: self, action: #selector(didOpenMenuPress))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "NavPhoto"), style: .plain, target: self, action: #selector(didNewRequestPress))
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "NavLogo"))
    }
    
    @objc private func didOpenMenuPress() {
        let menu = SideMenuNavigationController(rootViewController: MenuModule.instantiateTransitionHandler())
        menu.setNavigationBarHidden(true, animated: false)
        menu.statusBarEndAlpha = 0
        menu.leftSide = true
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = self.view.frame.width
        present(menu, animated: true, completion: nil)
    }
    
    @objc private func didNewRequestPress() {
        self.output?.didTriggerOpenNewRequest()
    }
    
    @objc private func refresh() {
        self.output?.didTriggerObtainFeed()
    }
}

// MARK: - MainViewInput

extension MainViewController: MainViewInput {
    
    func setupInitialState() {   
        setupCollectionView()
        setupNavigationBar()
    }

    func update(_ viewModels: [GoodieCellModel]) {
        collectionView?.refreshControl?.endRefreshing()
        contentManager?.updateData(viewModels)
    }
}

// MARK: - ViperViewOutputProvider

extension MainViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}


extension MainViewController : MainContentManagerImplementationDelegate {
    
    func didPostSelect(_ post: PostPlainObject) {
        self.output?.didTriggerOpenPostDetails(post)
    }
    
}
