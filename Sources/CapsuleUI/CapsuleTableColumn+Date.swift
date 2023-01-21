import SwiftUI

public extension CapsuleTableColumn {
  convenience init(_ title: String, value keyPath: KeyPath<RowValue, Date>, onSubmit: ((Int, Date) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(title))
    self.title = title
    self.keyPath = keyPath

    let cell = NSDatePickerCell()
    // cell.controlSize = .small
    dataCell = cell
  }
}
