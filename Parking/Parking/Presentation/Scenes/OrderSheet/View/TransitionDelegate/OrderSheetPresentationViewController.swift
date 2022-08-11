//
//  OrderSheetPresentationViewController.swift
//  Parking
//
//  Created by Maxim on 26.07.2022.
//

import UIKit


final class OrderSheetPresentationViewController: UIPresentationController {
    
    // MARK: - Forwarding touch through ContainerView

    private lazy var touchForvardView: TouchForwardView = {
        let view = TouchForwardView()
        view.touchForwardTargetViews = [presentingViewController.view]
        view.backgroundColor = .clear
        return view
    }()
    
    
    // MARK: - DimmView
    
    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    
    // MARK: - UIPresentationController

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        guard let containerView = containerView,
              let presentedView = presentedView
        else { return }
        containerView.addSubview(dimmView)
        containerView.addSubview(touchForvardView)
        touchForvardView.addSubview(presentedView)
        
        touchForvardView.translatesAutoresizingMaskIntoConstraints = false
        touchForvardView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        touchForvardView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        touchForvardView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        touchForvardView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    
        dimmView.translatesAutoresizingMaskIntoConstraints = false
        dimmView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dimmView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dimmView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dimmView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        presentedView.addGestureRecognizer(presentedViewPanGesture)
        presentedView.translatesAutoresizingMaskIntoConstraints = false
        let preferredHeightConstraint = presentedView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0)
        preferredHeightConstraint.priority = .fittingSizeLevel
        preferredHeightConstraint.isActive = true
        let maxHeightConstraint = presentedView.topAnchor.constraint(greaterThanOrEqualTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 24)
        maxHeightConstraint.priority = .required - 1
        maxHeightConstraint.isActive = true
        presentedView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        presentedView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        presentedView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
        dimmView.alpha = 1
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        dimmView.alpha = 0
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        UIView.animate(withDuration: 0.20,
                       delay: 0,
                       options: []) {
            self.presentedView?.layoutIfNeeded()
        }
    }
    
    
    // MARK: - PresentedView gesture
    
    private lazy var presentedViewPanGesture = UIPanGestureRecognizer(
        target: self,
        action: #selector(presentedViewDidPan)
    )
    
    @objc private func presentedViewDidPan(_ recognizer: UIPanGestureRecognizer) {
        guard let presentedView = presentedView,
              let superView = presentedView.superview else { return }
        let sheetMinYPoint = superView.frame.height - presentedView.frame.height
        let translation = recognizer.translation(in: presentedViewController.view.superview).y * 0.9
        let newPosition = presentedView.frame.offsetBy(dx: 0, dy: translation)
        // Ограничение перемещения BottomSheet размером в его максимальную высоту
        guard newPosition.minY > sheetMinYPoint else { return }
        presentedView.frame = newPosition
        recognizer.setTranslation(.zero, in: presentedView.superview)
        
        switch recognizer.state {
        case .ended:
            // Учитываю намерение пользователя через вычисление ожидаемого положения Вьюхи (умножаю координату смещения на коэффициент ускорения)
            let velocityCoeff = 1 + (recognizer.velocity(in: presentedViewController.view.superview).y / 1000)
            let projectedYLocation = newPosition.minY * velocityCoeff / 1.5
            // Сравниваю ожидаемое положение Вьюхи с средней от двух состояний Вью (медиум / лардж)
            let averageSheetMinYPoint = sheetMinYPoint + sheetMinYPoint * 0.25
            if projectedYLocation > averageSheetMinYPoint || newPosition.minY > averageSheetMinYPoint {
                presentedViewController.dismiss(animated: true, completion: nil)
            } else {
                bounceAnimation(callback: {
                    if let orderSheetVC = self.presentedViewController as? OrderSheetViewController {
                        orderSheetVC.collapseCells()
                    }
                })
            }
        default:
            break
        }
    }
    
    // Animation
    private func bounceAnimation(callback: @escaping () -> Void) {
        guard let superview = presentedViewController.view.superview else { return }
        UIView.animate(withDuration: 0.2, delay: 0, options: [], animations: { [self] in
            presentedViewController.view.frame =
            CGRect(x: 0,
                   y: CGFloat(superview.frame.height - presentedViewController.view.frame.height),
                   width: (presentedViewController.view.frame.width),
                   height: (presentedViewController.view.frame.height))
        }, completion: { _ in
            callback()
        })
    }
}
