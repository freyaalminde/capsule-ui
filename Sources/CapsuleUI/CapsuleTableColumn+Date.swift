import SwiftUI

public extension CapsuleTableColumn {
  convenience init(_ title: LocalizedStringKey, value keyPath: KeyPath<RowValue, Date>, onSubmit: ((Int, Date) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(title.string))
    self.title = title.string
    self.keyPath = keyPath

    let cell = NSDatePickerCell()
    // cell.controlSize = .small
    dataCell = cell
  }
}
