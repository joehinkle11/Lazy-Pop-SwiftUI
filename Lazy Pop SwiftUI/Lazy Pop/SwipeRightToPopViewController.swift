//
//  SwipeRightToPopViewController.swift
//  SwipeRightToPopController
//
//  Created by Warif Akhand Rishi on 2/19/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//
//  Modifed by Joseph Hinkle on 12/1/19.
//

import UIKit
import SwiftUI

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}

class SwipeRightToPopViewController<Content>: UIHostingController<Content>, UINavigationControllerDelegate where Content : View {

    var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition?
    var panGestureRecognizer: UIPanGestureRecognizer!

    public func addGesture() {

        guard parent?.parent?.navigationController?.viewControllers.count > 1 else {
            return
        }
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeRightToPopViewController.handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {

        let percent = max(panGesture.translation(in: view).x, 0) / view.frame.width

        switch panGesture.state {

        case .began:
            parent?.parent?.navigationController?.delegate = self
            _ = parent?.parent?.navigationController?.popViewController(animated: true)

        case .changed:
            if let percentDrivenInteractiveTransition = percentDrivenInteractiveTransition {
                percentDrivenInteractiveTransition.update(percent)
            }

        case .ended:
            let velocity = panGesture.velocity(in: view).x

            // Continue if drag more than 50% of screen width or velocity is higher than 100
            if percent > 0.5 || velocity > 100 {
                percentDrivenInteractiveTransition?.finish()
            } else {
                percentDrivenInteractiveTransition?.cancel()
            }

        case .cancelled, .failed:
            percentDrivenInteractiveTransition?.cancel()

        default:
            break
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return SlideAnimatedTransitioning()
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {

        parent?.parent?.navigationController?.delegate = nil
        navigationController.delegate = nil

        if panGestureRecognizer.state == .began {
            percentDrivenInteractiveTransition = UIPercentDrivenInteractiveTransition()
            percentDrivenInteractiveTransition?.completionCurve = .easeOut
        } else {
            percentDrivenInteractiveTransition = nil
        }

        return percentDrivenInteractiveTransition
    }
}


