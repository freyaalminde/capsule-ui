import SwiftUI

public extension CapsuleTableColumn {
  convenience init(_ title: LocalizedStringKey, value keyPath: KeyPath<RowValue, Bool>, onSubmit: ((Int, Bool) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(title.string))
    self.title = title.string
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

  convenience init(systemImage: String, value keyPath: KeyPath<RowValue, Bool>, onSubmit: ((Int, Bool) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(systemImage))
    self.title = systemImage
    self.keyPath = keyPath

    headerCell = NSTableHeaderCell()
    headerCell.image = NSImage(systemSymbolName: systemImage, accessibilityDescription: nil)?
      .withSymbolConfiguration(.init(paletteColors: [.textColor]).applying(.init(pointSize: NSFont.smallSystemFontSize, weight: .regular)))

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
