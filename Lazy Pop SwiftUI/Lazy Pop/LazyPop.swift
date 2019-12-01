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
//        let test = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
//        test.text = "heyyyy haha"
//        vc.view.addSubview(test)
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (_) in
            vc.addGesture()
        }
        return vc
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }
    
}
