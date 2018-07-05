//
//  CarCardViewController.swift
//  CarRecognition
//


import UIKit

internal final class CarCardViewController: TypedViewController<CarCardView> {

    struct Constants {
        static let entryPosition = UIScreen.main.bounds.maxY / 2
        static let exitPosition = UIScreen.main.bounds.maxY
    }

    /// Animator for entry animations
    private let entryAnimator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)

    /// Animator for exit animations
    private let exitAnimator = UIViewPropertyAnimator(duration: 0.7, curve: .linear)

    /// Car instance
    private let car: Car

    /// Initializes view controller with given View and car
    ///
    /// - Parameter viewMaker: Maker for the UIView
    /// - Parameter car: detected model of car
    init(viewMaker: @autoclosure @escaping () -> CarCardView, car: Car) {
        self.car = car
        super.init(viewMaker: viewMaker)
    }
    
    /// SeeAlso: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
    }

    /// Sets up properties of view controller
    private func setupProperties() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        view.addGestureRecognizer(gestureRecognizer)
        view.backgroundColor = .clear
    }

    /// Target for UIPanGestureRecogniser recognizer
    @objc func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            exitAnimator.addAnimations {
                let frame = self.view.frame
                self.view.frame = CGRect(x: 0, y: Constants.exitPosition, width: frame.width, height: frame.height)
            }
            exitAnimator.pausesOnCompletion = true
            exitAnimator.pauseAnimation()
        case .changed:
            let translation = recognizer.translation(in: view)
            exitAnimator.fractionComplete = translation.y / Constants.entryPosition
            
            if recognizer.direction == .bottomToTop, exitAnimator.fractionComplete == 0 {
                exitAnimator.stopAnimation(true)
                view.frame = CGRect(x: 0, y: Constants.entryPosition, width: view.frame.width, height: view.frame.height)
            }
        case .ended:
            exitAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default: break
        }
    }
    
    /// Animates card view from bottom of screen to desired position
    func animateIn() {
        entryAnimator.addAnimations {
            let frame = self.view.frame
            self.view.frame = CGRect(x: 0, y: Constants.entryPosition, width: frame.width, height: frame.height)
        }
        entryAnimator.startAnimation()
    }
}
