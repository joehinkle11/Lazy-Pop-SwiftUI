//
//  LazyPop.swift
//  Lazy Pop SwiftUI
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI

struct LazyPop<Content: View>: UIViewControllerRepresentable {
    let rootView: Content
    @Binding var lazyPopEnabled: Bool
    
    init(rootView: Content, lazyPopEnabled: (Binding<Bool>)? = nil) {
        self.rootView = rootView
        self._lazyPopEnabled = lazyPopEnabled ?? Binding<Bool>(get: { return true }, set: { _ in })
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
