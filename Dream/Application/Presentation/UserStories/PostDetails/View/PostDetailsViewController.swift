//
//  PostDetailsViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 22/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import FSPagerView

// MARK: - PostDetailsViewController

class PostDetailsViewController: UIViewController {
    
    private var post: PostPlainObject? {
        didSet {
            if let post = post {
                self.contentManager?.updateData(post)
            }
        }
    }
    
    // MARK: - Properties
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(MediaPage.self, forCellWithReuseIdentifier: MediaPage.reuseIdentifier)
        return pagerView
    }()
    
    private lazy var pageControl: FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.numberOfPages = post?.mediaList.count ?? 0
        pageControl.setFillColor(UIColor.pageLightGray, for: .normal)
        pageControl.setFillColor(.pagerRed, for: .selected)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 9, height: 9)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 9, height: 9)), for: .selected)
        pageControl.itemSpacing = 8
        pageControl.contentHorizontalAlignment = .left
        return pageControl
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkTextColor
        label.font = UIFont.regularFont(of: 13)
        return label
    }()
    
    fileprivate var collectionView: UICollectionView?

    /// Comments content manager
    var contentManager: CommentsContentManager?

    /// Presenter instance
    var output: PostDetailsViewOutput?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
        
        NotificationCenter.default.observeOnPostComment(withObserver: self, selector: #selector(didPostComment(_:)))
        NotificationCenter.default.observeOnVoteMedia(withObserver: self, selector: #selector(didVoteMedia(_:)))
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    /// Cards table view setup
    fileprivate func setupCollectionView() {
        guard let layout = contentManager?.collectionViewLayout() else {
            return
        }
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.keyboardDismissMode = .onDrag
        collectionView?.backgroundColor = UIColor.commentsBackgroundColor
        
        guard let collectionView = collectionView else {
            return
        }
        view.addSubview(collectionView.prepareForAutolayout())
        collectionView.pinToSuperview(withOffset: 0)
        contentManager?.configure(withCollectionView: collectionView)
    }

    // MARK: - Private
    private func setupLayout() {
        let screenHeight = UIScreen.main.bounds.height
        let tableViewHeight = screenHeight * 550.0 / 815.0
        
        let headerContainerView = UIView()
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        headerView.addSubview(pagerView.prepareForAutolayout())
        pagerView.pinToSuperview(withSides: .left, .right)
            .pinToSuperview(withSides: .top)
            .height.equal(to: tableViewHeight)
        
        headerView.addSubview(pageControl.prepareForAutolayout())
        pageControl.pinToSuperview(withSides: .left, andOffset: 20)
            .top(to: pagerView.bottom + 16)
        
        headerView.addSubview(titleLabel.prepareForAutolayout())
        titleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .top(to: pageControl.bottom + 16)
        
        headerView.addSubview(subTitleLabel.prepareForAutolayout())
        subTitleLabel.pinToSuperview(withSides: .left, .right, andOffset: 20)
            .top(to: titleLabel.bottom + 8)
        
        headerContainerView.addSubview(headerView.prepareForAutolayout())
        headerView.pinToSuperview()
    }
    
    func update(withUser user: UserPlainObject?) {
        if let user = user {
            let attributedString = NSMutableAttributedString(string: "\(user.name), \(user.age)")
            attributedString.addAttribute(.font, value: UIFont.regularFont(of: 22), range: NSMakeRange(0, attributedString.length))
            attributedString.addAttribute(.font, value: UIFont.mediumFont(of: 22), range: NSMakeRange(0, user.name.count))
            self.titleLabel.attributedText = attributedString
        }
    }
    
    private func updateUserFields() {
        if let userId = post?.userId {
            self.output?.didTriggeredObtainUser(userId)
        }
        subTitleLabel.text = post?.description
    }
    
    func update(_ viewModels: [CommentCellViewModelProtocol]) {
        self.contentManager?.updateData(viewModels)
    }
    
    @objc private func didPostComment(_ notification: Notification) {
        if let comment = notification.object as? String {
            self.output?.didTriggeredPostComment(comment)
        }
    }
    
    @objc private func didVoteMedia(_ notification: Notification) {
        if let mediaId = notification.object as? String {
            self.output?.didTriggeredVote(forMediaWithId: mediaId)
        }
    }
}

// MARK: - PostDetailsViewInput

extension PostDetailsViewController: PostDetailsViewInput {
    
    func setupInitialState(withPost post: PostPlainObject?) {
        self.view.backgroundColor = .white
        setupCollectionView()
//        setupLayout()
        
        self.post = post
    }
}

// MARK: - ViperViewOutputProvider

extension PostDetailsViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}

extension PostDetailsViewController : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        guard let post = post else {
            return 0
        }
        return post.mediaList.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: MediaPage.reuseIdentifier, at: index) as! MediaPage
        if let media = post?.mediaList[index] {
            cell.setup(withMedia: media)
        }
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
//        pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
//        pageControl.currentPage = pagerView.currentIndex
//        if pagerView.scrollOffset > 4 {
//            let diff = pagerView.scrollOffset - 4
//            self.pageControl.alpha = 1 - diff
//            self.nextButton.alpha = 1 - diff
//        } else {
//            self.pageControl.alpha = 1
//            self.nextButton.alpha = 1
//        }
    }
}

private class TouchHandleTableView: UITableView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let headerFrame = self.tableHeaderView?.frame, headerFrame.contains(point) {
            return nil
        } else {
            return super.hitTest(point, with: event)
        }
    }
    
}

