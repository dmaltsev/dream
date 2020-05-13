//
//  OnboardingViewController.swift
//  Dream
//
//  Created by Denis Maltsev on 15/03/2020.
//  Copyright © 2020 Мечтару. All rights reserved.
//

import UIKit
import FSPagerView

// MARK: - OnboardingViewController

class OnboardingViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.reuseIdentifier)
        pagerView.transformer = FSPagerViewTransformer(type: .depth)
        return pagerView
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "IconNext"), for: .normal)
        button.addTarget(self, action: #selector(didNextButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var pageControl: FSPageControl = {
        let pageControl = FSPageControl()
        pageControl.numberOfPages = images.count
        pageControl.setFillColor(UIColor.pagerGray.withAlphaComponent(0.5), for: .normal)
        pageControl.setFillColor(.white, for: .selected)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 3, y: 3, width: 9, height: 9)), for: .normal)
        pageControl.setPath(UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 15, height: 15)), for: .selected)
        pageControl.itemSpacing = 12
        pageControl.contentHorizontalAlignment = .left
        return pageControl
    }()
    
    private let images = [
        UIImage(named: "Onboarding1"),
        UIImage(named: "Onboarding2"),
        UIImage(named: "Onboarding3"),
        UIImage(named: "Onboarding4"),
        UIImage(named: "Onboarding5"),
        UIImage(named: "Onboarding6")
    ]

    /// Presenter instance
    var output: OnboardingViewOutput?
    
    // MARK: - ViewController

    override func viewDidLoad() {
    	super.viewDidLoad()
        output?.didTriggerViewReadyEvent()
    }

    // MARK: - Private
    private func setupPager() {
        self.view.addSubview(pagerView.prepareForAutolayout())
        pagerView.pinToSuperview()
    }
    
    private func setupNextButton() {
        self.view.addSubview(nextButton.prepareForAutolayout())
        nextButton.pinToSuperview(withSides: .right, andOffset: 32).pinToSuperview(withSides: .bottom, andOffset: 64)
    }
    
    private func setupPageControl() {
        self.view.addSubview(pageControl.prepareForAutolayout())
        pageControl.pinToSuperview(withSides: .left, andOffset: 55).centerY(to: nextButton.centerY)
    }
    
    @objc private func didNextButtonPressed() {
        pagerView.scrollToItem(at: pagerView.currentIndex + 1, animated: true)
    }
    
    @objc private func didAskAdvicePressed() {
        output?.didTriggerOpenMain()
    }
}

// MARK: - OnboardingViewInput

extension OnboardingViewController: OnboardingViewInput {
    
    func setupInitialState() {   
        setupPager()
        setupNextButton()
        setupPageControl()
    }
}

// MARK: - ViperViewOutputProvider

extension OnboardingViewController: ViewOutputProvider {
    var viewOutput: ModuleInput? {
        return self.output as? ModuleInput
    }
}

extension OnboardingViewController : FSPagerViewDelegate, FSPagerViewDataSource {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return images.count
    }
    
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseIdentifier, at: index) as! OnboardingCell
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.image = images[index]
        cell.actionButton.isHidden = index != 5
        cell.actionButton.setTitle(loc("ask_advice.2"), for: .normal)
        if index == 5 {
            cell.actionButton.addTarget(self, action: #selector(didAskAdvicePressed), for: .touchUpInside)
        } else {
            cell.actionButton.removeTarget(self, action: #selector(didAskAdvicePressed), for: .touchUpInside)
        }
        return cell
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
        if pagerView.scrollOffset > 4 {
            let diff = pagerView.scrollOffset - 4
            self.pageControl.alpha = 1 - diff
            self.nextButton.alpha = 1 - diff
        } else {
            self.pageControl.alpha = 1
            self.nextButton.alpha = 1
        }
    }
}
