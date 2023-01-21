import SwiftUI

public extension CapsuleTableColumn {
  convenience init(_ title: String, value keyPath: KeyPath<RowValue, Bool>, onSubmit: ((Int, Bool) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(title))
    self.title = title
    self.keyPath = keyPath

    var newValue: Int?
    var overridenRow: Int?
    valueTransform = { v, i in
      if newValue != nil && overridenRow == i {
        defer { newValue = nil; overridenRow = nil }
        return newValue!
      } else {
        return v
      }
    }

    if let onSubmit = onSubmit {
      self.onSubmit = { i in { v in
        newValue = (v as! Int)
        onSubmit(i, v as! Bool)
      } }
    }

    _action = { tableView in
      guard let tableView = tableView as? NSTableView else { return }
      overridenRow = tableView.clickedRow
    }

    let cell = NSButtonCell()
    cell.title = nil
    cell.setButtonType(.switch)
    cell.imagePosition = .imageOnly
    // cell.controlSize = .small
    cell.action = #selector(NSTableColumn._performAction(_:))
    cell.target = self
    dataCell = cell
  }
}
