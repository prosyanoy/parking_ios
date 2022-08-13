//
//  OnboardingViewController.swift
//  Parking
//
//  Created by Mikhail Chudaev on 13.08.2022.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {

    let firstPageDescriptionView: OnboardingView = {
        let page = OnboardingView(labelText: "First Page DescriptionView", imageName: "someName")
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    let secondPageDescriptionView: OnboardingView = {
        let page = OnboardingView(labelText: "Second Page DescriptionView", imageName: "someName")
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    var thirdPageDescriptionView: OnboardingView = {
        let page = OnboardingView(labelText: "Third Page DescriptionView", imageName: "someName")
        page.translatesAutoresizingMaskIntoConstraints = false
        return page
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        let buttonLightBlueBackgroundColor = UIColor(red: 13/255, green: 174/255, blue: 252/255, alpha: 1.0)
        button.backgroundColor = buttonLightBlueBackgroundColor
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(red: 57/255, green: 180/255, blue: 36/255, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(red:150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        return pageControl
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "someName"), for: .normal)
        button.tintColor = UIColor(red: 57/255, green: 180/255, blue: 36/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        let scrollLightWhiteBackgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        scroll.backgroundColor = scrollLightWhiteBackgroundColor
        scroll.isPagingEnabled = true
        scroll.isScrollEnabled = true
        scroll.alwaysBounceHorizontal = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width*3, height: UIScreen.main.bounds.size.height-50)
        
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setDelegates()
        setupLayout()
    }

    private func setDelegates() {
        scrollView.delegate = self
    }

    private func addTargets() {
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
    }

    private func setupLayout() {
        
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(pageControl)

        scrollView.addSubview(firstPageDescriptionView)
        scrollView.addSubview(secondPageDescriptionView)
        scrollView.addSubview(thirdPageDescriptionView)
            
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nextButton.heightAnchor.constraint(equalToConstant: 70),
            nextButton.widthAnchor.constraint(equalToConstant: 40),
            
            pageControl.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: view.bounds.height),
            scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            
            firstPageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            firstPageDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            firstPageDescriptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            firstPageDescriptionView.heightAnchor.constraint(equalTo: view.heightAnchor),

            secondPageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            secondPageDescriptionView.leadingAnchor.constraint(equalTo: firstPageDescriptionView.trailingAnchor),
            secondPageDescriptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            secondPageDescriptionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
            thirdPageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            thirdPageDescriptionView.leadingAnchor.constraint(equalTo: secondPageDescriptionView.trailingAnchor),
            thirdPageDescriptionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            thirdPageDescriptionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            
        ])
    }
    
}

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let pageNew = Int(round(scrollView.contentOffset.x / scrollView.bounds.width))
        if pageNew == pageControl.currentPage {
            return
        }
        pageControl.currentPage = Int(pageNew)
    }
}

extension OnboardingViewController {

    private func getNextPageScrollOffset() -> Int {
        (1 + pageControl.currentPage) * Int(view.frame.width)
    }

    @objc private func didTapNextButton(sender: UIView) {
        
        if (pageControl.currentPage + 1 == 4){
            let nextPageXoffset = self.getNextPageScrollOffset()
            self.scrollView.setContentOffset(CGPoint(x:nextPageXoffset, y: 0), animated: true)
            return
        }
        
        if (pageControl.currentPage + 1 == pageControl.numberOfPages){
            presentingViewController?.dismiss(animated: true, completion: nil)
            return
        }
        
        let nextPageXoffset = getNextPageScrollOffset()
        scrollView.setContentOffset(CGPoint(x:nextPageXoffset, y: 0), animated: true)
    }
    
    @objc private func didTapCloseButton(sender: UIView) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
