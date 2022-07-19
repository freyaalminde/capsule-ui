import SwiftUI
import PreviewsCapture

/// A list of capsule views.
public struct CapsuleList<Content: View>: View {
  var content: Content
  @State var group = CapsuleGroup()
  
  // @Environment(\.colorScheme) private var colorScheme
  
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
  
  public var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        content
      }
      .padding(.horizontal, 18)
      .padding(.vertical, 18)
    }
    .frame(alignment: .top)
    // .padding(.vertical, -18)
    // .background(colorScheme == .light ? .white : .background)
    .background(.background)
    .environment(\.capsuleGroup, group)
    // ._safeAreaInsets(EdgeInsets(top: 29 + 29 - 1, leading: 0, bottom: 0, trailing: 0))
  }
}

struct CapsuleList_Previews: PreviewProvider {
  struct Example: View {
    @State var isExpanded = true
    
    var body: some View {
      CapsuleList {
        Capsule("Example") {
          CapsuleTable_Previews.Example1()
        }
        Capsule("Second Example") {
          CapsuleTable_Previews.Example2()
        }
        Capsule("A Third Example", isExpanded: $isExpanded) {
          CapsuleTable_Previews.Example3()
        }
      }
    }
  }
  
  static var previews: some View {
    Example()
      .frame(minWidth: 480, minHeight: 480)
      .previewScreenshot("CapsuleList")
  }
}
