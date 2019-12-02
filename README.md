# Lazy Pop SwiftUI

Swiping on any part of the screen starts an interruptible pop animation to the previous view.

<p align="center"><img src="https://github.com/joehinkle11/Lazy-Pop-SwiftUI/raw/master/demo.gif"/></p>

Forked from https://github.com/rishi420/SwipeRightToPopController and adapted for SwiftUI.

# Use

To make your view lazily poppable, just put it inside a `LazyPop()` view.

```swift
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
If you would like to toggle when the lazy pop is enabled, just pass it a boolean state.

```swift
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
```

# Install

Just inlude the three files under `LazyPop` in this repo. Here's a link to them https://github.com/joehinkle11/Lazy-Pop-SwiftUI/tree/master/Lazy%20Pop%20SwiftUI/Lazy%20Pop

If this gets enough use, I'll put this in a Swift Package or a Cocopod.
