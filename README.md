# Lazy Pop SwiftUI

> iOS 26 now supports the "lazy pop" behavior by default. Therefore I'm archiving this repo.

Swiping on any part of the screen starts an interruptible pop animation to the previous view.

<p align="center"><img src="https://github.com/joehinkle11/Lazy-Pop-SwiftUI/raw/master/demo.gif"/></p>

Forked from https://github.com/rishi420/SwipeRightToPopController and adapted for SwiftUI.

Also thanks to [lyinsteve on this Reddit comment](https://www.reddit.com/r/iOSProgramming/comments/e4zeoi/i_made_a_swiftui_component_so_you_can_drag/f9gkllt/) for suggesting I turn this into modifier.

# App Store Demo

[![](https://raw.githubusercontent.com/joehinkle11/Lazy-Pop-SwiftUI/master/Lazy%20Pop%20SwiftUI/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60%402x.png)](https://apps.apple.com/us/app/lazy-pop-swiftui-demo/id1490371801)

[Download the Lazy Pop SwiftUI demo here!](https://apps.apple.com/us/app/lazy-pop-swiftui-demo/id1490371801)

# Use

To make your view lazily poppable, just add the `lazyPop()` modifer to it.

```swift
struct DetailsViewWithLazyPop: View {
    var body: some View {
        Text("Lazy pop enabled. Swipe anywhere to dismiss.")
        .lazyPop()
    }
}
```
If you would like to toggle when the lazy pop is enabled, just pass it a boolean state.

```swift
struct DetailsViewWithToggleableLazyPop: View {
    @State var isEnabled: Bool = true
    var body: some View {
        Toggle(isOn: $isEnabled) {
            Text("Toggle lazy pop")
        }
        .lazyPop(isEnabled: $isEnabled)
    }
}
```

# Gotchas

The current implementation does not play well with some SwiftUI modifiers like `.ignoresSafeArea()`. There is currently no known workaround. If you find anything related to this problem, you can write about it in [this issue](https://github.com/joehinkle11/Lazy-Pop-SwiftUI/issues/3#issuecomment-1079688013).

# Install

Just inlude the two files under `LazyPop` in this repo. Here's a link to them https://github.com/joehinkle11/Lazy-Pop-SwiftUI/tree/master/Lazy%20Pop%20SwiftUI/Lazy%20Pop

If this gets enough use, I'll put this in a Swift Package or a Cocopod.
