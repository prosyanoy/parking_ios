//
//  OnboardVC.swift
//  Parking
//
//  Created by Mikhail Chudaev on 29.07.2022.
//

import Foundation
import UIKit

class OnboardVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.addSubview(onePageDescriptionView)
        scrollView.addSubview(twoPageDescriptionView)
        scrollView.addSubview(threePageDescriptionView)
        
        view.addSubview(closeButton)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        
        onePageDescriptionView.addSubview(onePageDescriptionLabel)
        twoPageDescriptionView.addSubview(twoPageDescriptionLabel)
        threePageDescriptionView.addSubview(threePageDescriptionLabel)
        
        onePageDescriptionView.addSubview(onePageImageView)
        twoPageDescriptionView.addSubview(twoPageImageView)
        threePageDescriptionView.addSubview(threePageImageView)
        
        setupLayout()
    }
    
    func setupLayout() {
        
        layoutScrollView()
        layoutNextButton()
        layoutCloseButton()
        
        layoutOnePageView()
        layoutTwoPageView()
        layoutThreePageView()
        
        layoutPageControl()
    }
    
    var nextButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = UIColor(red: 13/255, green: 174/255, blue: 252/255, alpha: 1.0)
        button.setTitle("Продолжить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        
        button.layer.shadowRadius = 4.0
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize.zero
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    fileprivate func layoutNextButton() {
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor(red: 57/255, green: 180/255, blue: 36/255, alpha: 1.0)
        pageControl.pageIndicatorTintColor = UIColor(red:150/255, green: 150/255, blue: 150/255, alpha: 1.0)
        
        return pageControl
    }()
    
    fileprivate func layoutPageControl() {
        pageControl.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        pageControl.topAnchor.constraint(equalTo: onePageDescriptionLabel.bottomAnchor, constant: 20).isActive = true
    }
    
    var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"),for: .normal)
        button.tintColor = UIColor(red: 57/255, green: 180/255, blue: 36/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)

        return button
    }()
    
    fileprivate func layoutCloseButton() {
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        scroll.isPagingEnabled = true
        scroll.isScrollEnabled = true
        scroll.alwaysBounceHorizontal = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.contentSize = CGSize(width: UIScreen.main.bounds.width*3, height: UIScreen.main.bounds.size.height-50)
        
        return scroll
    }()
    
    fileprivate func layoutScrollView() {
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.bounds.height).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
    }
    
    var onePageDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var onePageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "One Description Label"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var onePageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "parkingsign")
        
        return imageView
    }()
    
    fileprivate func layoutOnePageView() {
        onePageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        onePageDescriptionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        onePageDescriptionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        onePageDescriptionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        addOnePageContent()
    }
    
    fileprivate func addOnePageContent() {
        onePageDescriptionLabel.centerXAnchor.constraint(equalTo: onePageDescriptionView.centerXAnchor).isActive = true
        onePageDescriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        onePageDescriptionLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        onePageDescriptionLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        onePageImageView.centerXAnchor.constraint(equalTo: onePageDescriptionView.centerXAnchor).isActive = true
        onePageImageView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 100).isActive = true
        onePageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        onePageImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    var twoPageDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var twoPageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Two Description Label"
        label.textColor = .magenta
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var twoPageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "parkingsign.circle")
        
        return imageView
    }()
    
    fileprivate func layoutTwoPageView() {
        twoPageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        twoPageDescriptionView.leadingAnchor.constraint(equalTo: onePageDescriptionView.trailingAnchor).isActive = true
        twoPageDescriptionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        twoPageDescriptionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        addTwoPageContent()
    }
    
    fileprivate func addTwoPageContent() {
        twoPageDescriptionLabel.centerXAnchor.constraint(equalTo: twoPageDescriptionView.centerXAnchor).isActive = true
        twoPageDescriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        twoPageDescriptionLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        twoPageDescriptionLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        twoPageImageView.centerXAnchor.constraint(equalTo: twoPageDescriptionView.centerXAnchor).isActive = true
        twoPageImageView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 100).isActive = true
        twoPageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        twoPageImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    var threePageDescriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var threePageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Three Description Label"
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    var threePageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "parkingsign.circle.fill")
        
        return imageView
    }()

    
    fileprivate func layoutThreePageView() {
        threePageDescriptionView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        threePageDescriptionView.leadingAnchor.constraint(equalTo: twoPageDescriptionView.trailingAnchor).isActive = true
        threePageDescriptionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        threePageDescriptionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        threePageDescriptionView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        
        addThreePageContent()
    }
    
    func addThreePageContent() {
        threePageDescriptionLabel.centerXAnchor.constraint(equalTo: threePageDescriptionView.centerXAnchor).isActive = true
        threePageDescriptionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100).isActive = true
        threePageDescriptionLabel.widthAnchor.constraint(equalToConstant: 270).isActive = true
        threePageDescriptionLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        threePageImageView.centerXAnchor.constraint(equalTo: threePageDescriptionView.centerXAnchor).isActive = true
        threePageImageView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 100).isActive = true
        threePageImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        threePageImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
}

extension OnboardVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        if pageIndex == pageControl.currentPage {
            return
        }
        pageControl.currentPage = Int(pageIndex)
    }
}

extension OnboardVC {
    
    fileprivate func getNextPageScrollOffset() -> Int {
        (1 + pageControl.currentPage) * Int(view.frame.width)
    }
    
    @objc func didTapNextButton(sender: UIView) {
            
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
    
    @objc func didTapCloseButton(sender: UIView) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
