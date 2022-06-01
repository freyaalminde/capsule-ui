import SwiftUI
import PreviewScreenshots

public class CapsuleTableView: NSTableView {
//  public override func drawCell(_ cell: NSCell) {
//    if !tableViewLocked {
//      super.drawCell(cell)
//    }
//  }
//  public override func reloadData() {
////     self.isEnabled = false
//  }
}

/// Capsular–tabular view.
/// ![](CapsuleTable)
public struct CapsuleTable<Data: RandomAccessCollection, ID>: NSViewRepresentable where ID == Data.Element.ID, Data.Element: Identifiable {
  var data: Data
//  var _data: Binding<Data>?
  let columns: [CapsuleTableColumn<Data.Element>]
  var selection: Binding<ID?>?
  var selectionSet: Binding<Set<ID>>?
  var allowsSelection: Bool { selection != nil || selectionSet != nil }
  @State var hiddenColumnIdentifiers = Set<NSUserInterfaceItemIdentifier>()
  
  @Environment(\.capsuleGroup) var group
  @Environment(\.tableStyle) var tableStyle

//  func dataAt(index: Int) -> Identifiable {
//
//  }
  
//  public init(_ data: Data, _ columns: [CapsuleTableColumn<Data.Element>]) {
//    self.data = data
//    self.columns = columns
//  }

  @_disfavoredOverload public init(_ data: Data, @CapsuleTableColumnBuilder<Data.Element> columns: () -> [CapsuleTableColumn<Data.Element>]) {
    self.data = data
    self.columns = columns()
  }

  public init(_ data: Data, selection: Binding<ID?>, @CapsuleTableColumnBuilder<Data.Element> columns: () -> [CapsuleTableColumn<Data.Element>]) {
    self.data = data
    self.columns = columns()
    self.selection = selection
  }

  public init(_ data: Data, selection: Binding<Set<ID>>, @CapsuleTableColumnBuilder<Data.Element> columns: () -> [CapsuleTableColumn<Data.Element>]) {
    self.data = data
    self.columns = columns()
    self.selectionSet = selection
  }

//  public init<C, E>(_ data: Data, @CapsuleTableColumnBuilder<Data.Element> columns: () -> [CapsuleTableColumn<Data.Element>]) where Data == Binding<C>, ID == E.ID, C: MutableCollection, C: RandomAccessCollection, E: Identifiable, E == C.Element {
//    self.data = data//.wrappedValue
//    self.columns = columns()
//  }

  public func makeNSView(context: Context) -> NSScrollView {
    // let tableView = CapsuleTableView(frame: NSRect(origin: .zero, size: NSSize(width: 200, height: 200)))
    let tableView = CapsuleTableView()
    
    if group != .undefined {
      group.tableViews.insert(tableView)
    }
    
    for column in columns {
      object_setClass(column.headerCell, CapsuleTableHeaderCell.self)
      column.isEditable = true
      tableView.addTableColumn(column)
    }
    
    tableView.delegate = context.coordinator
    tableView.dataSource = context.coordinator
    
    // tableView.style = tableStyle
    tableView.style = .plain
    tableView.focusRingType = .none
    tableView.gridStyleMask = [.solidHorizontalGridLineMask]
    // tableView.usesAlternatingRowBackgroundColors = true
    tableView.allowsMultipleSelection = selectionSet != nil
    tableView.allowsColumnReordering = false
    tableView.columnAutoresizingStyle = context.environment.tableColumnAutoresizing

    // tableView.intercellSpacing = NSMakeSize(8.5, 0)

    let headerMenu = NSMenu()
    headerMenu.items = columns.map {
      let item = NSMenuItem()
      item.title = $0.headerToolTip ?? $0.title
      item.state = .on
      item.target = context.coordinator
      item.action = #selector(Coordinator.toggleColumnVisibility(_:))
      item.representedObject = $0
      return item
    }
    headerMenu.autoenablesItems = false
    headerMenu.showsStateColumn = true
    headerMenu.font = NSFont.systemFont(ofSize: NSFont.systemFontSize(for: .small))
    tableView.headerView?.menu = headerMenu
    
    // tableView.headerView?.isHidden = false
//    print(tableView.rowHeight)
    tableView.rowHeight += 1
//    tableView.rowHeight = 24
    
    let scrollView = CapsuleTableScrollView()
    scrollView.isScrollEnabled = group == .undefined
    scrollView.documentView = tableView
    
    return scrollView
  }
  
  func noteSelectionChanged(in tableView: NSTableView, coordinator: Coordinator) {
    let newSelection = tableView.selectedRowIndexes.compactMap { coordinator.data[coordinator.data.index(coordinator.data.startIndex, offsetBy: $0)].id }
    selection?.wrappedValue = newSelection.first
    selectionSet?.wrappedValue = Set(newSelection)
  }
  
  public func updateNSView(_ scrollView: NSScrollView, context: Context) {
    let tableView = (scrollView.documentView as! CapsuleTableView)
    // NSLog(#function)
    let oldCount = context.coordinator.data.count
//    DispatchQueue.main.async {
    context.coordinator.data = data
    if oldCount != data.count {
      tableView.noteNumberOfRowsChanged()
//    tableView.reloadData()
      tableView.reloadData()
    
        tableView.invalidateIntrinsicContentSize()
        scrollView.invalidateIntrinsicContentSize()
//      tableView.sizeToFit()
      
      DispatchQueue.main.async { [self] in
        noteSelectionChanged(in: tableView, coordinator: context.coordinator)
      }
    }
    
    if data.count > oldCount {
//      DispatchQueue.main.async { [self] in
//        DispatchQueue.main.async { [self] in
//          tableView.selectRowIndexes([tableView.numberOfRows - 1], byExtendingSelection: false)
          tableView.selectRowIndexes([tableView.numberOfRows - 1], byExtendingSelection: false)
          DispatchQueue.main.async {
              DispatchQueue.main.async {
                DispatchQueue.main.async {
                  tableView.editColumn(0, row: tableView.numberOfRows - 1, with: nil, select: true)
              }
            }
          }
        }
//      }
//    }
////    }
    
    // tableView.delegate?.tableViewSelectionDidChange?(<#T##notification: Notification##Notification#>)
    // tableView.reloadData()
//    }
    
    DispatchQueue.main.async {
      tableView.reloadData()
    }
//      context.coordinator.data = data as! [Any?]
//    }
  

    
//        DispatchQueue.main.async {
//          tableView.reloadData()
//        }

    //scrollView.frame.size = tableView.fittingSize
    // scrollView.frame = NSMakeRect(0, 0, 320, 240)

    // tableView.frame.size.height = 999 // 29 + (24 * max(3, CGFloat(data.count)))
    // scrollView.frame.size.height = 999 // 29 + (24 * max(3, CGFloat(data.count)))
    // frame(height: 29 + (24 * max(3, CGFloat(rowCount))))
    
    //    DispatchQueue.main.async {
    //      tableView.noteNumberOfRowsChanged()
    //      tableView.needsDisplay = true
    //      tableView.needsLayout = true
    //    }
    
    for column in tableView.tableColumns {
      column.isHidden = hiddenColumnIdentifiers.contains(column.identifier)
      for item in tableView.headerView?.menu?.items ?? [] {
        guard let object = item.representedObject as? NSTableColumn, object == column else { continue }
        item.state = column.isHidden ? .off : .on
      }
    }
  }
  
  public func makeCoordinator() -> Coordinator {
    Coordinator(self, data)
  }
  
  public class Coordinator: NSObject, NSTableViewDataSource, NSTableViewDelegate {
    var parent: CapsuleTable
    var data: Data
    
    init(_ parent: CapsuleTable, _ data: Data) {
      self.parent = parent
      self.data = data
    }
    
    public func numberOfRows(in tableView: NSTableView) -> Int {
      data.count
    }
    
    // public func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
    //   return 32
    // }
    
    public func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
      return parent.allowsSelection
    }
    
    @objc func toggleColumnVisibility(_ sender: NSMenuItem) {
      guard let column = sender.representedObject as? CapsuleTableColumn<Data.Element> else { return }
      
      if !parent.hiddenColumnIdentifiers.contains(column.identifier) {
        parent.hiddenColumnIdentifiers.insert(column.identifier)
      } else {
        parent.hiddenColumnIdentifiers.remove(column.identifier)
      }
    }
    
    public func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
      // guard data.count - 1 > row else { return nil }
      guard let tableColumn = tableColumn as? CapsuleTableColumn<Data.Element> else { return nil }
       let rowIndex = data.index(data.startIndex, offsetBy: row)
      guard let rowData = data[safe: rowIndex] else { return nil }
//      let rowData = data[row]
      
      // var rowData: Any?
      // if let dataBinding = parent.data as? Binding<RandomAccessCollection> {
      //   rowData = dataBinding.wrappedValue
      // } else {
      //   rowData = parent.data[rowIndex]
      // }

//      if let keyPath = tableColumn.keyPath as? KeyPath<Data.Element, String> {
//        var value = rowData[keyPath: keyPath]
//        if let transform = tableColumn.valueTransform { value = transform(value as Any, row) }
//
//        if let image = tableColumn._image?(rowData) {
//          return (image, value)
//        }
//
//        return value
//      }
      
//      if let keyPath = tableColumn.keyPath as? KeyPath<Data.Element, Binding<AnyHashable?>> {
//        var value = rowData[keyPath: keyPath].wrappedValue
//        if let transform = tableColumn.valueTransform { value = (transform(value as Any) as! AnyHashable) }
//        return value
//      }
      
      if let keyPath = tableColumn.keyPath as? AnyKeyPath {
        var value = rowData[keyPath: keyPath]
        if let transform = tableColumn.valueTransform { value = transform(value as Any, row) }
        if let image = tableColumn._image?(rowData) { return (image, value) }
        return value
      }

//      if let keyPath = tableColumn.keyPath as? KeyPath<Data.Element, CaseIterable> {
//        return rowData[keyPath: keyPath]
//      }

      return nil
    }
    
    public func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
//      (cell as? NSCell)?.title = String(describing: self.tableView(tableView, objectValueFor: tableColumn!, row: row))
      
//      if 
      
    }
    
    public func tableViewSelectionIsChanging(_ notification: Notification) {
//      parent.selectionSet
      guard let tableView = notification.object as? NSTableView else { return }
      parent.noteSelectionChanged(in: tableView, coordinator: self)
    }

    public func tableView(_ tableView: NSTableView, setObjectValue object: Any?, for tableColumn: NSTableColumn?, row: Int) {
      guard let tableColumn = tableColumn as? CapsuleTableColumn<Data.Element> else { return }
      guard let onSubmit = tableColumn.onSubmit else { return }
      onSubmit(row)(object)
      // tableView.setNeedsDisplay()
      // tableView.reloadData(forRowIndexes: [row], columnIndexes: [tableView.column(withIdentifier: tableColumn.identifier)])
      // tableView.delegate?.tableView(<#T##NSTableView#>, dataCellFor: <#T##NSTableColumn?#>, row: <#T##Int#>)
      //tableView.cell

//      if let keyPath = tableColumn.keyPath as? KeyPath<Data.Element, Binding<String>> {
//        if let value = object as? String {
//          rowData[keyPath: keyPath].wrappedValue = value
//          //parent.data[rowIndex] = rowData
//        }
//      }
    }

    public func tableView(_ tableView: NSTableView, sortDescriptorsDidChange oldDescriptors: [NSSortDescriptor]) {
    }

    public func tableViewSelectionDidChange(_ notification: Notification) {
      guard let tableView = notification.object as? NSTableView else { return }
      DispatchQueue.main.async { self.parent.noteSelectionChanged(in: tableView, coordinator: self) }
      
      guard !parent.group.isIterating else { return }
      parent.group.isIterating = true
      
      for tableView in parent.group.tableViews.filter({ $0 != notification.object as? NSTableView }) {
        for index in tableView.selectedRowIndexes {
          tableView.deselectRow(index)
        }
      }
      
      parent.group.isIterating = false
    }
    
    public func selectionShouldChange(in tableView: NSTableView) -> Bool {
      if tableView.clickedColumn >= 0 {
        let dataCell = tableView.tableColumns[tableView.clickedColumn].dataCell
        if dataCell is NSButtonCell { // || dataCell is NSComboBoxCell {
          return false
        }
      }
      
      return true
    }
  }
}

class CapsuleTableHeaderCell: NSTableHeaderCell {
  // override var font: NSFont? { get { nil } set { }}
//  override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
//    super.drawInterior(withFrame: cellFrame.insetBy(dx: -5, dy: 0), in: controlView)
//  }
}
extension Collection {
  /// Returns the element at the specified index if it is within bounds, otherwise nil.
  subscript(safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

enum Flavor: String, CaseIterable, Identifiable {
  case chocolate, vanilla, strawberry
  var id: Self { self }
  var localizedDescription: String { String(describing: self) }
  var color: Color {
    switch self {
    case .chocolate: return .indigo
    case .vanilla: return .yellow
    case .strawberry: return .orange
    }
  }
}

struct Person: Identifiable {
  let id = UUID()
  var givenName: String
  var familyName: String
  var favoriteFlavor: Flavor
  var usesSwift = true
  var birthday = Date()
  
  var attributedFamilyName: NSAttributedString {
    NSAttributedString(string: familyName, attributes: [.foregroundColor: NSColor.systemPink])
  }
  
  //    var durr: some View {
  //      Label("durr", systemImage: "dd")
  //    }
}

class Person2: Identifiable {
  let id = UUID()
  var name = ""
  var usesSwift = true
  var favoriteFlavor = Flavor.chocolate
  
  init(name: String, usesSwift: Bool, favoriteFlavor: Flavor) {
    self.name = name
    self.usesSwift = usesSwift
    self.favoriteFlavor = favoriteFlavor
  }
}

class DBColumn: Identifiable {
  let id = UUID()
  var name = "property"
  var type = "undefined"
  var isRequired = false
}

struct CapsuleTable_Previews: PreviewProvider {
  static var people = [
    Person(givenName: "Juan", familyName: "Chavez", favoriteFlavor: .chocolate),
    Person(givenName: "Mei", familyName: "Chen", favoriteFlavor: .vanilla),
    Person(givenName: "Tom", familyName: "Clark", favoriteFlavor: .strawberry, usesSwift: false),
    Person(givenName: "Gita", familyName: "Kumar", favoriteFlavor: .strawberry),
  ]
  
  struct Example1: View {
    @State var data = people

    var body: some View {
      CapsuleTable(data) {
        CapsuleTableColumn("􀊴", value: \.usesSwift).withAlignment(.center).withWidth(20)
        CapsuleTableColumn("Given Name", value: \.givenName)
          .withAlignment(.right)
        
        CapsuleTableColumn("Family Name", value: \.attributedFamilyName)
        // CapsuleTableColumn("Birthday", value: \.birthday)
      }
      .padding(.bottom)
      // CapsuleFooter()
    }
  }
  
  struct Example2: View {
    @State var data = [DBColumn()]
    @State var selection: DBColumn.ID?

    var body: some View {
      VStack(spacing: 0) {
        CapsuleTable(data, selection: $selection) {
          CapsuleTableColumn("Name", value: \.name) { data[$0].name = $1 }
          CapsuleTableColumn("Type", value: \.type) { data[$0].type = $1 }
          CapsuleTableColumn("􀅎", value: \.isRequired) { data[$0].isRequired = $1 }
            .withAlignment(.center)
            .withWidth(20)
            .withToolTip("Required")
        }
        .onDeleteCommand {
          if selection == nil { NSSound.beep() }
          data.removeAll { selection == $0.id }
        }
        
        CapsuleFooter(canRemove: selection != nil, onAdd: {
          data.append(DBColumn())
        }, onRemove: {
          data.removeAll { selection == $0.id }
        })
      }
    }
  }

  struct Example3: View {
    @State var i = 0
    @State var data = people
    @State var selection = Set<Person.ID>()
    @Environment(\.undoManager) var undoManager
    
    var body: some View {
      let _ = Self._printChanges()
      // let _ = print(undoManager)
      
      VStack(spacing: 0) {
        CapsuleTable(data, selection: $selection) {
          CapsuleTableColumn("Name", value: \.givenName) { data[$0].givenName = $1 }
            .withImage {
              NSImage(systemSymbolName: "star.fill", accessibilityDescription: nil)?
                .withSymbolConfiguration(.init(paletteColors: [NSColor($0.favoriteFlavor.color)]))
            }
          
          CapsuleTableColumn("Type", value: \.familyName) { data[$0].familyName = $1 }
          
          CapsuleTableColumn("Favorite", value: \.favoriteFlavor) { data[$0].favoriteFlavor = $1 }
          
          // CapsuleTableColumn("Birthday", value: \Person.birthday)
        }
  //      .id(i)
        .onDeleteCommand {
          if selection.isEmpty { NSSound.beep() }
          data.removeAll { selection.contains($0.id) }
        }
        
  //      CapsuleTable(data) {
  //        CapsuleTableColumn("Name", value: \.givenName)
  //          .withImage { _ in
  //            NSImage(systemSymbolName: "star.fill", accessibilityDescription: nil)?
  //              .withSymbolConfiguration(.init(paletteColors: [NSColor.systemOrange]))
  //          }
  //
  //        CapsuleTableColumn("Type", value: \.familyName)
  //
  //        CapsuleTableColumn("Favorite", value: \.favoriteFlavor)
  //
  //        // CapsuleTableColumn("Birthday", value: \Person.birthday)
  //      }
        
        CapsuleFooter(canRemove: !selection.isEmpty, onAdd: {
          data.append(Person(givenName: "", familyName: "", favoriteFlavor: .chocolate))
        }, onRemove: {
          data.removeAll { selection.contains($0.id) }
        })
      }
//      Button("wtf") {
//        data = [
//          Person(givenName: "AAAAA", familyName: "Chavez", favoriteFlavor: .chocolate),
//          Person(givenName: "AAAAA", familyName: "Chen", favoriteFlavor: .vanilla),
//          Person(givenName: "Tom", familyName: "Clark", favoriteFlavor: .strawberry, usesSwift: false),
//          // Person(givenName: "AAAAA", familyName: "Chen", favoriteFlavor: .vanilla),
//        ]
//      }
//
//      Button("+") { i += 1 }
//
//      Text(String(describing: selection))
//
//      Table(data) {
//        TableColumn("ID", value: \.id.uuidString)
//        TableColumn("Name", value: \.givenName)
//        TableColumn("Type", value: \.familyName)
//        TableColumn("Favorite", value: \.favoriteFlavor.localizedDescription)
//      }
//      .frame(minWidth: 400, minHeight: 120)

    }
  }

  struct ReadMeExample: View {
    @State var data = [
      Person2(name: "Juan Chavez", usesSwift: true, favoriteFlavor: .chocolate),
      Person2(name: "Mei Chen", usesSwift: true, favoriteFlavor: .vanilla),
      Person2(name: "Tom Clark", usesSwift: false, favoriteFlavor: .strawberry),
      Person2(name: "Gita Kumar", usesSwift: true, favoriteFlavor: .strawberry),
    ]

    @State var selection = Set<Person2.ID>()
    
    var body: some View {
      let _ = Self._printChanges()
      
//      CapsuleTable(data, selection: $selection, columns: { [
//        CapsuleTableColumn<Person2>("", value: \.name)
//      ] })
      
      VStack(spacing: 0) {
        CapsuleTable(data, selection: $selection) {
          CapsuleTableColumn("Name", value: \.name) { data[$0].name = $1 }
            .withImage {
              NSImage(systemSymbolName: "person", accessibilityDescription: nil)?
                .withSymbolConfiguration(.init(paletteColors: [NSColor($0.favoriteFlavor.color)]))
            }
          
          
          CapsuleTableColumn("􀫊", value: \.usesSwift) { data[$0].usesSwift = $1 }
            .withAlignment(.center)
            .withToolTip("Uses Swift")
            .withWidth(20)

          CapsuleTableColumn("Favorite Flavor", value: \.favoriteFlavor) { data[$0].favoriteFlavor = $1 }
        }
        
  //      CapsuleFooter(canRemove: !selection.isEmpty, onAdd: {
  //        data.append(Person2(name: "", usesSwift: false, favoriteFlavor: .chocolate))
  //      }, onRemove: {
  //        data.removeAll { selection.contains($0.id) }
  //      })
      }
    }
  }
  
  static var previews: some View {
//    ScreenshotGroup("Documentation.docc/Resources", relativeTo: #filePath) {
//      ReadMeExample()
//        .frame(width: 247, height: 124)
//        // .frame(minWidth: 480, minHeight: 480)
//        // .screenshotName("CapsuleTable")
//    }

    Example1()
    Example2()
    Example3()
  }
}
