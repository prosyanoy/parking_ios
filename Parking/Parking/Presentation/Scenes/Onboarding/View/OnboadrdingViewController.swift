//
//  OnboadrdingPageViewController.swift
//  Parking
//
//  Created by mac on 02.09.2022.
//

import UIKit


protocol OnboardingPageViewControllerProtocol {

}
    
final class OnboadrdingViewController: UIViewController {
   
    private let viewModel: OboardingPageViewModel
    private let pageVC: PageViewController
    
    init(viewModel: OboardingPageViewModel, pageVC: PageViewController, nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = viewModel
        self.pageVC = pageVC
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let onboardingView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(onboardingView)
        addChild(pageVC)
        pageVC.view.translatesAutoresizingMaskIntoConstraints = false
        onboardingView.addSubview(pageVC.view)
        setupLayout()
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
        
            onboardingView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pageVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        pageVC.didMove(toParent: self)
    }
}
