import SwiftUI

class CapsuleGroup: Equatable {
  static var undefined = CapsuleGroup()
  static func == (lhs: CapsuleGroup, rhs: CapsuleGroup) -> Bool { ObjectIdentifier(lhs) == ObjectIdentifier(rhs) }
  var tableViews = Set<NSTableView>()
  var isIterating = false
  init() {}
}

public typealias CapsuleTableColumnAutoresizing = NSTableView.ColumnAutoresizingStyle
public typealias CapsuleTableStyle = NSTableView.Style

struct CapsuleGroupKey: EnvironmentKey {
  static var defaultValue = CapsuleGroup.undefined
}

struct TableColumnAutoresizingKey: EnvironmentKey {
  static var defaultValue = CapsuleTableColumnAutoresizing.noColumnAutoresizing
}

struct TableStyleKey: EnvironmentKey {
  static var defaultValue = CapsuleTableStyle.automatic
}

extension EnvironmentValues {
  var capsuleGroup: CapsuleGroup {
    get { self[CapsuleGroupKey.self] }
    set { self[CapsuleGroupKey.self] = newValue }
  }
}

public extension EnvironmentValues {
  var tableColumnAutoresizing: CapsuleTableColumnAutoresizing {
    get { self[TableColumnAutoresizingKey.self] }
    set { self[TableColumnAutoresizingKey.self] = newValue }
  }
  
  var tableStyle: CapsuleTableStyle {
    get { self[TableStyleKey.self] }
    set { self[TableStyleKey.self] = newValue }
  }
}

public extension View {
  func tableColumnAutoresizing(_ value: CapsuleTableColumnAutoresizing) -> some View {
    environment(\.tableColumnAutoresizing, value)
  }
  
  func tableStyle(_ value: CapsuleTableStyle) -> some View {
    environment(\.tableStyle, value)
  }
}

//public extension View {
//  // TODO: respect `controlSize`, don’t hardcode everything
//  func fixedSize(rowCount: Int) -> some View {
//    // frame(height: (rowCount == 0 ? 0.5 : 0) + 28 + (24 * max(3, CGFloat(rowCount))))
//    frame(height: 29 + (24 * max(3, CGFloat(rowCount))))
//  }
//}
