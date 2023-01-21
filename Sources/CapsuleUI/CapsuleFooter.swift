import SwiftUI

/// Capsule footer view.
public struct CapsuleFooter: View {
  static var buttonSize: CGFloat { 24 }
  
  var canRemove = false
  var onAdd: () -> Void
  var onRemove: () -> Void
  
  public init(canRemove: Bool = false, onAdd: (() -> Void)? = nil, onRemove: (() -> Void)? = nil) {
    self.canRemove = canRemove
    self.onAdd = onAdd ?? {}
    self.onRemove = onRemove ?? {}
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      if let onAdd = onAdd {
        Button(action: onAdd) {
          Label("Add item", systemImage: "plus")
            .frame(width: Self.buttonSize, height: Self.buttonSize)
        }
      }
      
      if let onRemove = onRemove {
        Button(action: onRemove) {
          Label("Remove items", systemImage: "minus")
            .frame(width: Self.buttonSize, height: Self.buttonSize)
        }
        .disabled(!canRemove)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 0.5)
    .padding(.bottom, 1.5)
    .padding(.bottom, 10)
    //.padding(.vertical, 5)
    //.padding(.top, -5)
    .buttonStyle(.borderless)
    .labelStyle(.iconOnly)
    .imageScale(.large)
  }
}

struct CapsuleFooter_Previews: PreviewProvider {
  static var previews: some View {
    CapsuleFooter()
      .frame(minWidth: 400)
  }
}
