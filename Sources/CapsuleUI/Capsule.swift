import SwiftUI

/// An expandable capsule view.
public struct Capsule<Content: View>: View {
  //let title: LocalizedStringKey
  let title: String
  var isExpandedBinding: Binding<Bool>?
  @State var isExpandedState: Bool = true
  var isExpanded: Binding<Bool> { isExpandedBinding ?? $isExpandedState }
  let content: () -> Content

  // TODO: add StringProtocol initializer also
  public init(_ title: String, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: @escaping () -> Content) {
    // public init(_ title: LocalizedStringKey, isExpanded: Binding<Bool>? = nil, @ViewBuilder content: () -> Content) {
    self.title = title
    isExpandedBinding = isExpanded
    self.content = content
  }
  
  public var body: some View {
    DisclosureGroup(isExpanded: isExpanded) {
      VStack(spacing: 0) {
        content()
      }
      .padding(.leading, 9)
    } label: {
      Text(title)
        .font(.callout.bold())
        .padding(.horizontal, 5)
        .padding(.vertical, 6)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background()
        .onTapGesture {
          isExpanded.wrappedValue.toggle()
        }
    }
    .padding(.horizontal, 16)
    .padding(.bottom, 3)
    // .padding(.vertical, 8)
    .overlay(alignment: .bottom) {
      Divider()
    }
    .transaction { transaction in
      transaction.animation = nil
    }
  }
}

#if DEBUG

struct Capsule_Previews: PreviewProvider {
  static var previews: some View {
    Capsule("Title") {
      Text("Content").padding()
    }
  }
}

#endif
