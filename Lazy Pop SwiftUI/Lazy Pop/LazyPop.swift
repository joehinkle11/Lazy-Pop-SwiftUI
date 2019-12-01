//
//  LazyPop.swift
//  Lazy Pop SwiftUI
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI


struct LazyPop<Content: View>: UIViewControllerRepresentable {
    var rootView: Content

    func makeUIViewController(context: Context) -> UIViewController {
        let vc = SwipeRightToPopViewController(rootView: rootView)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            vc.addGesture()
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
    
}
