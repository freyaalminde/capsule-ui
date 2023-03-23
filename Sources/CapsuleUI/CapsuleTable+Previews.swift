import SwiftUI
//import PreviewsCapture

struct CapsuleTable_Previews: PreviewProvider {
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
        CapsuleTableColumn(systemImage: "heart", value: \.usesSwift).withAlignment(.center).withWidth(20)
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
          CapsuleTableColumn(systemImage: "exclamationmark", value: \.isRequired) { data[$0].isRequired = $1 }
            .withAlignment(.center)
            .withWidth(20)
            .withToolTip("Required")
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
          
          CapsuleTableColumn("Surname", value: \.familyName) { data[$0].familyName = $1 }
          
          CapsuleTableColumn("Favorite", value: \.favoriteFlavor) { data[$0].favoriteFlavor = $1 }

          CapsuleTableColumn(systemImage: "swift", value: \.usesSwift) { data[$0].usesSwift = $1 }
            .withAlignment(.center)
            .withToolTip("Uses Swift")
            .width(20)

          CapsuleTableColumn("Favorite", value: \.favoriteFlavor) { data[$0].favoriteFlavor = $1 }

          CapsuleTableColumn("Favorite", value: \.favoriteFlavor) { data[$0].favoriteFlavor = $1 }

          // CapsuleTableColumn("Birthday", value: \.birthday) { data[$0].birthday = $1 }

          CapsuleTableColumn("Static Column") { "Oh hi, \($0)!" }
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
//    // ScreenshotGroup("Documentation.docc/Resources", relativeTo: #filePath) {
//      ReadMeExample()
//        .frame(width: 247, height: 124)
//        // .frame(minWidth: 480, minHeight: 480)
//        // .previewDisplayName("CapsuleTable")
//    // }

    Example1()
    Example2()
    Example3()
  }
}
