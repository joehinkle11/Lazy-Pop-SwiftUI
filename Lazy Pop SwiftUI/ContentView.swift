//
//  ContentView.swift
//  Lazy Pop SwiftUI
//
//  Created by Joseph Hinkle on 12/1/19.
//  Copyright © 2019 Joseph Hinkle. All rights reserved.
//

import SwiftUI

func makeList() -> [String] {
    var array: [String] = []
    for i in 1...100 {
        array.append("List element \(i)")
    }
    return array
}

let list = makeList()

struct ContentView: View {
    var body: some View {
        NavigationView {
            List (list, id: \.self) { item in
                Text(item)
            }
            .navigationBarTitle("Lazy Pop SwiftUI")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
