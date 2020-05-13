//
//  MenuViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 05/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit

// MARK: - MenuViewController

class MenuViewController: UIViewController {
    
    // MARK: - Properties
    
    /// Table with Menu cells
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .backgroundGray
        tableView.bounces = false
        return tableView
    }()
    
    private lazy var tableHeaderView: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 160)
        return label
    }()

    /// Presenter instance
    var output: MenuViewOutput?

    /// Menu content manager
    var contentManager: MenuContentManager?
    
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
        tableView.tableHeaderView = tableHeaderView
        contentManager?.configure(withTableView: tableView)
    }
}

// MARK: - MenuViewInput

extension MenuViewController: MenuViewInput {
    
    func setupInitialState() {   
        setupTableView()
    }
    
    func update(_ viewModels: [MenuCellViewModelProtocol]) {
        contentManager?.updateData(viewModels)
    }
}

// MARK: - ViperViewOutputProvider

extension MenuViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}
