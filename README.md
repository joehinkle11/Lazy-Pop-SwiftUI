# Lazy Pop SwiftUI

Swiping on any part of the screen starts an interruptible pop animation to the previous view.

<p align="center"><img src="https://github.com/joehinkle11/Lazy-Pop-SwiftUI/raw/master/demo.gif"/></p>

Forked from https://github.com/rishi420/SwipeRightToPopController and adapted for SwiftUI.

# Use

```swift
struct DetailsView: View {
    @State var item: (Int, String)
    var body: some View {
        Text("Default behavior enabled. Swipe from the leftmost part of the screen to dismiss.")
        .navigationBarTitle(item.1)
    }
}

struct DetailsViewWithToggleableLazyPop: View {
    @State var item: (Int, String)
    @State var isEnabled: Bool = true
    var body: some View {
        VStack {
            LazyPop(
                rootView: VStack {
                    Toggle(isOn: $isEnabled) {
                        Text("Toggle lazy pop")
                    }.padding(100)
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

struct DetailsViewWithLazyPop: View {
    @State var item: (Int, String)
    var body: some View {
        LazyPop(
            rootView: Text("Lazy pop enabled. Swipe anywhere to dismiss.")
        )
        .navigationBarTitle(item.1)
    }
}
```
