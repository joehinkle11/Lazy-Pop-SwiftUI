//
//  ContentView.swift
//  Lazy Pop SwiftUI
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI

func makeList() -> [(Int, String)] {
    var array: [(Int, String)] = []
    for i in 1...100 {
        if i % 2 == 0 {
            array.append((i, "\(i). Lazy pop."))
        } else {
            array.append((i, "\(i). Default behavior."))
        }
    }
    return array
}

let list = makeList()

struct ContentView: View {
    var body: some View {
        NavigationView {
            List (list, id: \.0) { item in
                if item.0 % 2 == 0 {
                    // Lazy pop
                    NavigationLink(
                        destination: DetailsViewWithLazyPop(item: item)
                    ) {
                        Text(item.1)
                        .bold()
                    }
                } else {
                    // Default behavior
                    NavigationLink(
                        destination: DetailsView(item: item)
                    ) {
                        Text(item.1)
                    }
                }
            }
            .navigationBarTitle("Lazy Pop SwiftUI")
        }
    }
}

struct DetailsView: View {
    @State var item: (Int, String)
    var body: some View {
        Text("Default behavior enabled. Swipe from the leftmost part of the screen to dismiss.")
        .navigationBarTitle(item.1)
    }
}


struct DetailsViewWithLazyPop: View {
    @State var item: (Int, String)
    @State var isEnabled: Bool = true
    var body: some View {
        VStack {
            LazyPop(
                rootView: VStack {
                    Toggle(isOn: $isEnabled) {
                        Text("Toggle lazy pop")
                    }.padding(10)
                    if isEnabled {
                        Text("Lazy pop enabled. Swipe anywhere to dismiss.")
                    } else {
                        Text("Lazy pop disabled.")
                    }
                },
                lazyPopEnabled: $isEnabled
            )
        }
        .navigationBarTitle(item.1)
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
