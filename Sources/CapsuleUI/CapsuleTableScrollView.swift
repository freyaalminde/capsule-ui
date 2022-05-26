import SwiftUI

class CapsuleTableScrollView: NSScrollView {
  var isScrollEnabled = false
  
  override var intrinsicContentSize: NSSize {
    guard !isScrollEnabled else { return super.intrinsicContentSize }
    guard let tableView = documentView as? NSTableView else { return .zero }
    var height = documentView?.intrinsicContentSize.height ?? super.intrinsicContentSize.height
    height = max(height, tableView.rowHeight * 3 + 1)
    if let header = tableView.headerView { height += header.bounds.height }
    return NSMakeSize(-1, height)
  }
  
  override func scrollWheel(with event: NSEvent) {
    guard !isScrollEnabled else { return }
    nextResponder?.scrollWheel(with: event)
  }
}
