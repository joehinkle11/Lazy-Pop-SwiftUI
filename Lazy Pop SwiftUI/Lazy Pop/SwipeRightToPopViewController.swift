//
//  SwipeRightToPopViewController.swift
//  SwipeRightToPopController
//
//  Created by Warif Akhand Rishi on 2/19/16.
//  Copyright © 2016 Warif Akhand Rishi. All rights reserved.
//
//  Modified by Joseph Hinkle on 12/1/19.
//  Modified version allows use in SwiftUI by subclassing UIHostingController.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

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

    fileprivate var lazyPopContent: LazyPop<Content>?
    private var percentDrivenInteractiveTransition: UIPercentDrivenInteractiveTransition?
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var parentNavigationControllerToUse: UINavigationController?

    public func addGesture() {
        // attempt to find a parent navigationController
        var currentVc: UIViewController = self
        for _ in 0...100 {
            if (currentVc.navigationController != nil) &&
               currentVc.navigationController?.viewControllers.count > 1
                {
                parentNavigationControllerToUse = currentVc.navigationController
                break
            }
            currentVc = currentVc.parent ?? currentVc
        }
        guard parentNavigationControllerToUse?.viewControllers.count > 1 else {
            return
        }
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeRightToPopViewController.handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    @objc func handlePanGesture(_ panGesture: UIPanGestureRecognizer) {

        let percent = max(panGesture.translation(in: view).x, 0) / view.frame.width

        switch panGesture.state {

        case .began:
            if lazyPopContent?.enabled == true {
                parentNavigationControllerToUse?.delegate = self
                _ = parentNavigationControllerToUse?.popViewController(animated: true)
            }

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

        parentNavigationControllerToUse?.delegate = nil
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


//
//  Lazy Pop SwiftUI Component
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

fileprivate struct LazyPop<Content: View>: UIViewControllerRepresentable {
    let rootView: Content
    @Binding var enabled: Bool
    
    init(_ rootView: Content, enabled: (Binding<Bool>)? = nil) {
        self.rootView = rootView
        self._enabled = enabled ?? Binding<Bool>(get: { return true }, set: { _ in })
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = SwipeRightToPopViewController(rootView: rootView)
        vc.lazyPopContent = self
        // A timer is needed because the vc is not added to the view hierarchy until after we return it
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            vc.addGesture()
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if let host = uiViewController as? UIHostingController<Content> {
            host.rootView = rootView
        }
    }
}
extension View {
    public func lazyPop(enabled: (Binding<Bool>)? = nil) -> some View {
        return LazyPop(self, enabled: enabled)
    }
}
