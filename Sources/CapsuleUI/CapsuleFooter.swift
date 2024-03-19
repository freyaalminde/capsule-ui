import SwiftUI

/// Capsule footer view.
public struct CapsuleFooter: View {
  private static var buttonSize: CGFloat { 24 }

  private var canAdd = false
  private var canRemove = false
  private var onAdd: (() -> Void)?
  private var onRemove: (() -> Void)?
  
  public init(
    canAdd: Bool = true,
    canRemove: Bool = false,
    onAdd: (() -> Void)? = nil,
    onRemove: (() -> Void)? = nil
  ) {
    self.canAdd = canAdd
    self.canRemove = canRemove
    self.onAdd = onAdd
    self.onRemove = onRemove
  }
  
  public var body: some View {
    HStack(spacing: 0) {
      if let onAdd {
        Button(action: onAdd) {
          Label("Add item", systemImage: "plus")
            .frame(width: Self.buttonSize, height: Self.buttonSize)
        }
        .disabled(!canAdd)
      }
      
      if let onRemove {
        Button(action: onRemove) {
          Label("Remove items", systemImage: "minus")
            .frame(width: Self.buttonSize, height: Self.buttonSize)
        }
        .disabled(!canRemove)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 0.5)
    .padding(.bottom, 11.5)
    .buttonStyle(.borderless)
    .labelStyle(.iconOnly)
    .imageScale(.large)
  }
}

#if DEBUG

struct CapsuleFooter_Previews: PreviewProvider {
  static var previews: some View {
    CapsuleFooter(onAdd: {}, onRemove: {})
      .frame(minWidth: 400)
  }
}

#endif
