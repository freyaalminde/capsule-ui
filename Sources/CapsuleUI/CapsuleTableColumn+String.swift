import SwiftUI

public extension CapsuleTableColumn {
  // TODO: should be `String?`, i guess — ditto for every other column
  convenience init(_ title: LocalizedStringKey, value keyPath: KeyPath<RowValue, String>, onSubmit: ((Int, String) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier("\(title)"))
    self.title = "\(title)"
    self.keyPath = keyPath

    if let onSubmit = onSubmit {
      self.onSubmit = { i in { v in onSubmit(i, v as! String) } }
    }

    let cell = CapsuleTableLabelCell()
    cell.isEditable = onSubmit != nil
    cell.truncatesLastVisibleLine = true
    dataCell = cell
  }

  convenience init(_ title: LocalizedStringKey, value keyPath: KeyPath<RowValue, NSAttributedString>, onSubmit: ((Int, String) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier("\(title)"))
    self.title = "\(title)"
    self.keyPath = keyPath
    
    if let onSubmit = onSubmit {
      self.onSubmit = { i in { v in onSubmit(i, v as! String) } }
    }

    let cell = CapsuleTableLabelCell()
    cell.isEditable = onSubmit != nil
    cell.truncatesLastVisibleLine = true
    dataCell = cell
  }

  convenience init(_ title: LocalizedStringKey, value: @escaping (RowValue) -> Any?) {
    self.init(identifier: NSUserInterfaceItemIdentifier("\(title)"))
    self.title = "\(title)"

    valueTransform = { v, _ in value(v as! RowValue) }

    let cell = CapsuleTableLabelCell()
    cell.isEditable = false
    cell.truncatesLastVisibleLine = true
    dataCell = cell
  }
}
