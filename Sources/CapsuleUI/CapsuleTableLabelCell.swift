import SwiftUI

// TODO: clean this the heck up, omg, lol

/// Cell for displaying text alongside optional image.
open class CapsuleTableLabelCell: NSTextFieldCell {
  var _image: Unmanaged<NSImage>?
  // unowned(unsafe) var _image: NSImage?
//  var _image: NSImage?
  
//  open override func titleRect(forBounds bounds: NSRect) -> NSRect {
//    var titleFrame = super.titleRect(forBounds: bounds)
//    let titleSize = attributedStringValue.size()
//    titleFrame.origin.y = bounds.origin.y - 1 + (bounds.size.height - titleSize.height) / 2
////      if imageValue != nil {
////        let imageWidth = imageRect(forBounds: bounds).width + 5
////        titleFrame.origin.x += imageWidth
////        titleFrame.size.width -= imageWidth
////      }
//    return titleFrame
//  }
//
//  open override func drawInterior(withFrame frame: NSRect, in controlView: NSView) {
////      if var image = imageValue {
////        if isHighlighted {
////          image = image.withSymbolConfiguration(.init(paletteColors: [NSColor.white]))!
////        }
////
////        image.draw(in: imageRect(forBounds: frame))
////      }
//
//    var stringDrawingOptions: NSString.DrawingOptions = [.usesLineFragmentOrigin]
//    if truncatesLastVisibleLine { stringDrawingOptions.insert(.truncatesLastVisibleLine) }
//    attributedStringValue.draw(with: titleRect(forBounds: frame), options: stringDrawingOptions)
//  }
  
  open override var objectValue: Any? {
    get { super.objectValue }
    set {
      if let (image, object) = newValue as? (NSImage, Any?) {
         _image = Unmanaged.passUnretained(image)
//        _image = image
        super.objectValue = object
      } else {
        super.objectValue = newValue
      }
    }
  }
  
  var imageValue: NSImage? {
//    // NSTableView().row(at: <#T##NSPoint#>)
//    guard let (image, _) = objectValue as? (NSImage, Any?) else { return nil }
////    guard (objectValue as? [Any?])?[0] is NSImage
//    return image
////    return nil
    ///
    _image?.takeUnretainedValue()
//    _image
//    _image
  }
  
//  open override var attributedStringValue: NSAttributedString {
//    get {
//      guard let (_, string) = objectValue as? (NSImage, String) else { return super.attributedStringValue }
//      let attributes = super.attributedStringValue.attributes(at: 0, effectiveRange: nil)
//      let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
////      attributedString.
////      attributedString.addAttributes([.font: font as Any], range: NSMakeRange(0, super.attributedStringValue.length - 1))
//      return attributedString
//    }
//    set {
//      super.attributedStringValue = newValue
//    }
//  }

  var imageSpacing = NSSize(width: 5, height: 0)
  
  open override func imageRect(forBounds bounds: NSRect) -> NSRect {
    guard let size = imageValue?.size else { return .zero }
    let y = floor(bounds.origin.y + (bounds.size.height - size.height) / 2)
    let point = NSPoint(x: bounds.origin.x, y: y)
    return NSRect(origin: point, size: size)
  }
  
  open override func titleRect(forBounds bounds: NSRect) -> NSRect {
    var titleFrame = super.titleRect(forBounds: bounds)
    let titleSize = attributedStringValue.size()
    titleFrame.origin.y = bounds.origin.y + (bounds.size.height - titleSize.height) / 2
    if imageValue != nil {
      let imageWidth = imageRect(forBounds: bounds).width + imageSpacing.width
      titleFrame.origin.x += imageWidth
      titleFrame.size.width -= imageWidth
    }
    return titleFrame
  }
  
  open override func cellSize(forBounds rect: NSRect) -> NSSize {
    var size = super.cellSize(forBounds: rect)
    size.width += imageRect(forBounds: rect).width + imageSpacing.width
    return size
  }
  
  open override func drawInterior(withFrame frame: NSRect, in controlView: NSView) {
    // let frame = frame.insetBy(dx: -5, dy: 0)
    
    if var image = imageValue {
      if isHighlighted {
        image = image.withSymbolConfiguration(.init(paletteColors: [NSColor.white]))!
      }
      
      image.draw(in: imageRect(forBounds: frame))
    }

    var stringDrawingOptions: NSString.DrawingOptions = [.usesLineFragmentOrigin]
    if truncatesLastVisibleLine { stringDrawingOptions.insert(.truncatesLastVisibleLine) }
    attributedStringValue.draw(with: titleRect(forBounds: frame), options: stringDrawingOptions)
  }
  
//  open override func drawingRect(forBounds rect: NSRect) -> NSRect {
//    super.drawingRect(forBounds: rect).insetBy(dx: -20, dy: 0)
//  }
  
  open override func edit(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, event: NSEvent?) {
    var rect = rect
    if imageValue != nil {
      let imageWidth = imageRect(forBounds: controlView.bounds).width + imageSpacing.width
      rect.origin.x += imageWidth
      rect.size.width -= imageWidth
    }
    super.edit(withFrame: rect.insetBy(dx: -2, dy: 4).offsetBy(dx: 0, dy: 0.5), in: controlView, editor: textObj, delegate: delegate, event: event)
    
  }

  open override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
    var rect = rect
    if imageValue != nil {
      let imageWidth = imageRect(forBounds: controlView.bounds).width + imageSpacing.width
      rect.origin.x += imageWidth
      rect.size.width -= imageWidth
    }
    super.select(withFrame: rect.insetBy(dx: -2, dy: 4).offsetBy(dx: 0, dy: 0.5), in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
  }

  open override func drawFocusRingMask(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawFocusRingMask(withFrame: cellFrame.insetBy(dx: 0, dy: 2.5).offsetBy(dx: 0, dy: -0.5), in: controlView)
  }
  
//    override func draw(withFrame cellFrame: NSRect, in controlView: NSView) {
//      super.draw(withFrame: cellFrame.insetBy(dx: -8, dy: 0), in: controlView)
//    }
//
//    override func draw(withExpansionFrame cellFrame: NSRect, in view: NSView) {
//      super.draw(withExpansionFrame: cellFrame.insetBy(dx: -8, dy: 0), in: view)
//    }

//  open override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
//    let textFrame = titleRect(forBounds: cellFrame).insetBy(dx: 0, dy: 2.5).offsetBy(dx: 0, dy: -0.5)
//    super.drawInterior(withFrame: textFrame, in: controlView)
//    imageValue?.draw(in: imageRect(forBounds: cellFrame))
//  }
  
  open override func expansionFrame(withFrame cellFrame: NSRect, in view: NSView) -> NSRect {
    titleRect(forBounds: cellFrame)
  }
  
  open override func draw(withExpansionFrame cellFrame: NSRect, in view: NSView) {
    var stringDrawingOptions: NSString.DrawingOptions = [.usesLineFragmentOrigin]
    if truncatesLastVisibleLine { stringDrawingOptions.insert(.truncatesLastVisibleLine) }
    attributedStringValue.draw(with: expansionFrame(withFrame: cellFrame, in: view), options: stringDrawingOptions)
  }
}
