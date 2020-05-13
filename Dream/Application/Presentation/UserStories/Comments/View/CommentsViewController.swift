//
//  CommentsViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 01/04/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - CommentsViewController

class CommentsViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Table with Comment cells
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()

    /// Presenter instance
    var output: CommentsViewOutput?

    /// Comments content manager
    var contentManager: CommentsContentManager?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
    }

    // MARK: - Private

    /// Cards table view setup
    fileprivate func setupTableView() {
        view.addSubview(tableView.prepareForAutolayout())
        tableView.pinToSuperview(withOffset: 0)
        
    }
}

// MARK: - CommentsViewInput

extension CommentsViewController: CommentsViewInput {
    
    func setupInitialState() {   
        setupTableView()
    }
    
    func update(_ viewModels: [CommentCellViewModelProtocol]) {
        
    }
}

// MARK: - ViperViewOutputProvider

extension CommentsViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}
