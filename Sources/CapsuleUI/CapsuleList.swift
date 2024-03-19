import SwiftUI
//import PreviewsCapture

/// A list of capsule views.
public struct CapsuleList<Content: View>: View {
  var content: Content
  @State var group = CapsuleGroup()

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
    .background(.background)
    .environment(\.capsuleGroup, group)
  }
}

#if DEBUG

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
      .previewDisplayName("CapsuleList")
  }
}

#endif
