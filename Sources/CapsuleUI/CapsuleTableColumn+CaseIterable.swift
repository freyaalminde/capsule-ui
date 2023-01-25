import SwiftUI

// TODO: add some kind of `displayName` or `localizedName` to this
public extension CapsuleTableColumn {
  convenience init<V: CaseIterable & Equatable>(_ title: String, value keyPath: KeyPath<RowValue, V>, onSubmit: ((Int, V) -> Void)? = nil) {
    self.init(identifier: NSUserInterfaceItemIdentifier(title))
    self.title = title
    self.keyPath = keyPath

    let cell = CapsuleTablePopUpButtonCell()
    cell.isBordered = false
    cell.isEnabled = onSubmit != nil
    cell.imageDimsWhenDisabled = false
    let menu = NSMenu()
    menu.items = V.allCases.enumerated().map { (offset, element) in
      let item = NSMenuItem(title: "\(element)".firstCapitalized, action: nil, keyEquivalent: "")
      item.tag = offset
      return item
    }
    cell.menu = menu
    cell.action = #selector(NSTableColumn._performAction(_:))
    cell.target = self
    //cell.sendsActionOnEndEditing = false
//    cell.select(cell.menu?.items.first)
    var newValue: Int?
    var overridenRow: Int?
    // var valueOverrideRow
    valueTransform = { v, i in
      if newValue != nil && overridenRow == i {
        defer { newValue = nil; overridenRow = nil }
        return newValue!
      } else {
        return V.allCases.enumerated().first(where: { (_, e) in e == v as! V })?.offset
      }
    }
    // cell.controlSize = .small
    dataCell = cell

    _action = { tableView in
      guard let tableView = tableView as? NSTableView else { return }

      overridenRow = tableView.clickedRow
////      tableViewLocked = true
//////      DispatchQueue.main.async {
//////        NSApp.runModal(for: (tableView as! NSView).window!)
//////      }
//////      tableView.lock()
//////      tableView.unlock()
//////      tableViewLocked = true
//////      (tableView as? NSTableView)?.dataSource = nil
////      NSLog("action")
////      // NSApp.stop(nil)
    }

    if let onSubmit = onSubmit {
      self.onSubmit = { i in { v in
        NSLog("submit")
        // NSApp.run()
//        cell.objectValue = v
        // cell.isBordered.toggle()
        // objectValue = v
        // self.valueTransform = { _ in v }
        // self.objectValue(for: <#T##RowValue#>, row: <#T##Int#>)
//        NSApp.abortModal()
        // NSDisableScreenUpdates()
        newValue = (v as! Int)
//        NSAnimationContext.runAnimationGroup { _ in
          onSubmit(i, V.allCases[v as! V.AllCases.Index])
//        }

        // DispatchQueue.main.async {
        //   DispatchQueue.main.async {
        //     NSEnableScreenUpdates()
        //   }
        // }
//        tableViewLocked = false
//        newValue = v as? Int
        // self.tableView?.setNeedsDisplay(self.tableView!.bounds)
//        DispatchQueue.main.async {
//          newValue
//        }

        // self.tableView?.reloadData()
//         self.tableView?.setNeedsDisplay(self.tableView!.bounds)
//        DispatchQueue.main.async {
//          tableViewLocked = false
//          self.tableView?.reloadData()
//        }
        // self.tableView?.reloadData()
//        cell.objectValue = v
        //cell.selectItem(at: v as! Int)
      } }
    }
  }
}

open class CapsuleTablePopUpButtonCell: NSPopUpButtonCell {
//  override func titleRect(forBounds cellFrame: NSRect) -> NSRect {
//    super.titleRect(forBounds: cellFrame.insetBy(dx: -5, dy: 0))
//  }

  open override func drawingRect(forBounds rect: NSRect) -> NSRect {
    super.drawingRect(forBounds: rect.insetBy(dx: -2.5, dy: 6))
  }

//  open override func focusRingMaskBounds(forFrame cellFrame: NSRect, in controlView: NSView) -> NSRect {
//    super.focusRingMaskBounds(forFrame: cellFrame.insetBy(dx: -2, dy: 4).offsetBy(dx: 0, dy: 0.5), in: controlView)
//  }

//  open override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.draw(withFrame: cellFrame.insetBy(dx: 5, dy: 5), in: controlView)
//  }

//  override func cellSize(forBounds rect: NSRect) -> NSSize {
//    var s = super.cellSize(forBounds: rect)
//    s.width += 5 * 2
//    return s
//  }

//  override func drawSeparatorItem(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawSeparatorItem(withFrame: cellFrame, in: controlView)
//  }
//
//  override func drawBorderAndBackground(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawBorderAndBackground(withFrame: cellFrame.insetBy(dx: -5, dy: 0), in: controlView)
//  }

//  override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.draw(withFrame: cellFrame.insetBy(dx: -5, dy: 0), in: controlView)
//  }

//  override func drawBorderAndBackground(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawBorderAndBackground(withFrame: cellFrame.insetBy(dx: -5, dy: 0), in: controlView)
//  }

//  override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawInterior(withFrame: cellFrame.insetBy(dx: -5, dy: 0), in: controlView)
//  }
}
