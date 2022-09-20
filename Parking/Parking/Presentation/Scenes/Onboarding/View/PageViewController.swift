//
//  MenuRegisrtrationViewController.swift
//  Parking
//
//  Created by Denis Zagudaev on 21.08.2022.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var delegateCodeEnterVC: CodeEnterViewModelProtocol?
    
    var pages = [UIViewController]()
    
    // external controls
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        
        return pageControl
    }()
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor( .white, for: .normal)
        button.setTitle("Назад", for: .normal)
        return button
    }()
    let skipButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor( .white, for: .normal)
        button.setTitle("Пропустить", for: .normal)
        return button
    }()
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.4274509804, blue: 0.8470588235, alpha: 1)
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.layer.cornerRadius = 52
        return button
    }()
    let progressBar: CircularProgressBarView = {
        let prBar = CircularProgressBarView(frame: CGRect(x: 154, y: 735, width: 120, height: 120))
        prBar.translatesAutoresizingMaskIntoConstraints = false
        prBar.trackColor = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        prBar.progressColor = #colorLiteral(red: 0.5607843137, green: 0.4274509804, blue: 0.8470588235, alpha: 1)
        return prBar
    }()
    
//    let progressBar = CircularProgressBarView(frame: CGRect(x: 154, y: 735, width: 120, height: 120))
    let initialPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageVieController()
        setupLayout()
        removeSwipeGesture()
    }
}

extension PageViewController {
    
    func setupPageVieController() {
        dataSource = self
        delegate = self
        
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let page1 = OnboardingPageViewController(
            imageName: "onboarding1",
            titleText: "Поиск парковок поблизости",
            subtitleText: "Ищите и сравнивайте автостоянки по цене и расположению"
        )
        let page2 = OnboardingPageViewController(
            imageName: "onboarding2",
            titleText: "Бронирование и оплата на выезде",
            subtitleText: "Платите заранее по факту брони или по факту выезда с парковки"
        )
        
        let page3 = OnboardingPageViewController(
            imageName: "onboarding3",
            titleText: "Неограниченная стоянка по абонементу",
            subtitleText: "Паркуйтесь на всех стоянках Сочи и Адлера. От 9.99999₽/месяц"
        )
        let page4 = GeoOnboardingViewController(
            imageName: "onboarding4",
            titleText: "Чтобы правильно определять ваше местоположение, приложение запросит доступ к данным геолокации"
        )
        
        let page5 = CityAndPhoneConfigurator.configure()
        
        guard let page6 = UserPhoneNumberConfirmationConfigurator.configure() as? UserPhoneNumberConfirmationViewController else { return }
        page6.delegate = self
        
//        let page7 = NewCarViewController()
//        let page7 = NewCarConfigurator.configure()
        
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
//        pages.append(page6)
//        pages.append(page7)
        
        
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func setupLayout() {
        view.addSubview(progressBar)
        view.addSubview(backButton)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            skipButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 61),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 743),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 162),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -162),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -79),
        ])
    }
    
    // - stop scrolling pages
    private func removeSwipeGesture() {
        self.view.subviews.forEach({ view in
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
                return
            }
        })
    }
}

//MARK: - DataSourse
extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currendIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currendIndex == 0 {
            print("First Page")
            return nil
        } else {
            return pages[currendIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currendIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currendIndex < pages.count - 1 {
            return pages[currendIndex + 1]
        } else {
            print("Last Page")
            return nil
        }
    }
}

//MARK: - Deligates

extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        isHiddenOrNotButton()
    }
}

//MARK: - Actions

extension PageViewController {
    
    @objc func backTapped() {
        pageControl.currentPage -= 1
        goToBackPage()
    }
    @objc func nextTapped() {
        pageControl.currentPage += 1
        goToNextPage()
    }
    @objc func skipTapped() {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
    }
    
    func isHiddenOrNotButton() {
        if pageControl.currentPage >= 0 && pageControl.currentPage <= 2 {
            skipButton.isHidden = false
            backButton.isHidden = false
            progressBar.isHidden = false
        } else {
            skipButton.isHidden = true
            backButton.isHidden = true
            progressBar.isHidden = true
        }
        
        if pageControl.currentPage > 3 {
            nextButton.isHidden = true
        } else if pageControl.currentPage <= 3 {
            nextButton.isHidden = false
        }
        
        progressBar.conditionStatusBar(Int: pageControl.currentPage)
    }
}

//MARK: - Extensions

extension PageViewController {
    func goToBackPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let backPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        setViewControllers([backPage], direction: .reverse, animated: animated, completion: completion)
        isHiddenOrNotButton()
    }
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
        isHiddenOrNotButton()
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
        isHiddenOrNotButton()
    }
}

protocol PageViewControllerDelegate: class {
    func goToLastPage(_ sender: UIButton)
    func goToNextPage(_ sender: UIButton)
    func goToPageNumber(_ sender: UIButton)
}

extension PageViewController: PageViewControllerDelegate {
  
    func goToLastPage(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
    }
    func goToNextPage(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
    }
    func goToPageNumber(_ sender: UIButton) {
        print("Have Connect")
        pageControl.currentPage = 5
        goToSpecificPage(index: pageControl.currentPage, ofViewControllers: pages)
    }
}
