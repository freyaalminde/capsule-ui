import SwiftUI

/// An expandable capsule view.
public struct Capsule<Content: View>: View {
  var title: LocalizedStringKey
  var isExpandedBinding: Binding<Bool>?
  @State var isExpandedState: Bool = true
  var isExpanded: Binding<Bool> { isExpandedBinding ?? $isExpandedState.projectedValue }
  var content: Content
  
  // TODO: add StringProtocol initializer also
  public init(_ title: LocalizedStringKey, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) {
    self.title = title
    isExpandedBinding = isExpanded
    self.content = content()
  }
  
  public var body: some View {
    DisclosureGroup(isExpanded: isExpanded) {
      VStack(spacing: 0) {
        content
//          .fixedSize()
      }
      .padding(.leading, 9)
      //.frame(maxWidth: .infinity, minHeight: 32) // FIXME
    } label: {
      Text(title)
        .font(.callout.bold())
        .padding(.horizontal, 5)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background()
        .onTapGesture {
          // withAnimation {
            isExpanded.wrappedValue.toggle()
          // }
        }
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 3)
    // .padding(.vertical, 8)
    .overlay(alignment: .bottom) {
      Divider()
    }
  }
}

struct Capsule_Previews: PreviewProvider {
  static var previews: some View {
    Capsule("Title") {
      Text("Content").padding()
    }
  }
}
