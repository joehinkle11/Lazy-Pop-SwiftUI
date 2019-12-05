//
//  ContentView.swift
//  Lazy Pop SwiftUI
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Code Examples")) {
                    NavigationLink(
                        destination: Example1()
                    ) {
                        Text("Example 1")
                    }
                    NavigationLink(
                        destination: Example2()
                    ) {
                        Text("Example 2")
                    }
                }
                Spacer()
                Section(header: Text("Demos")) {
                    NavigationLink(
                        destination: DetailsView()
                    ) {
                        Text("Default behavior 😑")
                    }
                    NavigationLink(
                        destination: DetailsViewWithLazyPop()
                    ) {
                        Text("Lazy pop 🗯️")
                    }
                    NavigationLink(
                        destination: DetailsViewWithToggleableLazyPop()
                    ) {
                        Text("Toggleable lazy pop 🔦")
                    }
                }
                Spacer()
                Section(header: Text("Links")) {
                    Button(action: {
                        let webURL = URL(string: "https://github.com/joehinkle11/Lazy-Pop-SwiftUI")!
                        if UIApplication.shared.canOpenURL(webURL as URL) {
                            UIApplication.shared.open(webURL)
                        }
                    }) {
                        Text("Source Code on GitHub 📃")
                    }
                    Button(action: {
                        let screenName =  "joehink95"
                        let appURL = URL(string: "twitter://user?screen_name=\(screenName)")!
                        let webURL = URL(string: "https://twitter.com/\(screenName)")!
                        if UIApplication.shared.canOpenURL(appURL as URL) {
                            UIApplication.shared.open(appURL)
                        } else {
                            UIApplication.shared.open(webURL)
                        }
                    }) {
                        Text("Contact me ♥️")
                    }
                    Button(action: {
                        let tweetText = "I found a SwiftUI component called Lazy Pop which lets you dismiss a view by dragging anywhere! #SwiftUI"
                        let tweetUrl = "https://github.com/joehinkle11/Lazy-Pop-SwiftUI"
                        let shareString = "https://twitter.com/intent/tweet?text=\(tweetText)&url=\(tweetUrl)"
                        let escapedShareString = shareString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                        let url = URL(string: escapedShareString)!
                        UIApplication.shared.open(url)
                    }) {
                        Text("Share 🐦")
                    }
                }
            }
            .navigationBarTitle("Lazy Pop SwiftUI")
        }
    }
}

struct Example1: View {
    var body: some View {
        VStack {
            Text("To enabled Lazy Pop on your SwiftUI view, just add the \".lazyPop()\" modifier to your existing view.")
                .padding(50)
            Image("example1")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        .lazyPop()
        .navigationBarTitle("Example 1")
    }
}

struct Example2: View {
    var body: some View {
        VStack {
            Text("If you want to toggle the effect, you can pass a boolean @State to the modifier.")
                .padding(50)
            Image("example2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
        }
        .lazyPop()
        .navigationBarTitle("Example 2")
    }
}

struct DetailsView: View {
    var body: some View {
        Text("Default behavior enabled 🥱 Swipe from the leftmost part of the screen to dismiss...").padding(50)
        .navigationBarTitle("Default behavior 😑")
    }
}

struct DetailsViewWithLazyPop: View {
    var body: some View {
        Text("Lazy pop enabled 😄 Swipe anywhere to dismiss ↔️").padding(50)
        .lazyPop()
        .navigationBarTitle("Lazy pop 🗯️")
    }
}

struct DetailsViewWithToggleableLazyPop: View {
    @State var isEnabled: Bool = true
    var body: some View {
        VStack {
            Toggle(isOn: $isEnabled) {
                if isEnabled {
                    Text("Lazy pop on")
                } else {
                    Text("Lazy pop off")
                }
            }.padding(100)
            if isEnabled {
                Text("Lazy pop enabled 😄 Swipe anywhere to dismiss ↔️").padding(50)
            } else {
                Text("Lazy pop disabled 😭").padding(50)
            }
        }
        .lazyPop(isEnabled: $isEnabled)
        .navigationBarTitle("Toggleable lazy pop 🔦")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
