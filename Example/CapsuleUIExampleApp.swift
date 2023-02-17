import SwiftUI
import PreviewsCapture
@testable import CapsuleUI
import IDEIcons

@main
struct CapsuleUIExampleApp: App {
  var body: some Scene {
    WindowGroup {
      CapsuleList {
        Capsule("Example") {
          CapsuleTable_Previews.Example1()
        }
        Capsule("Second Example") {
          CapsuleTable_Previews.Example2()
        }
        Capsule("A Third Example") {
          CapsuleTable_Previews.Example3()
        }
        Capsule("Data Model") {
          DataModelExample()
          CapsuleFooter()
        }
      }
    }
  }
}

struct DataModelAttribute: Identifiable {
  let id = UUID()
  var name = "attribute"
  var dataType = "undefined"
  var isRequired = false
}

let dataTypeCompletions = [
  (IDEIcon("B").image, "boolean"),
  (IDEIcon("B").image, "bytea"),
  (IDEIcon("C").image, "char"),
  (IDEIcon("D").image, "date"),
  (IDEIcon("F").image, "float4"),
  (IDEIcon("F").image, "float8"),
  (IDEIcon("S").image, "string"),
  (IDEIcon("I").image, "int2"),
  (IDEIcon("I").image, "int4"),
  (IDEIcon("I").image, "int8"),
  (IDEIcon("I").image, "interval"),
  (IDEIcon("J").image, "json"),
  (IDEIcon("J").image, "jsonb"),
  (IDEIcon("N").image, "numeric"),
  (IDEIcon("T").image, "text"),
  (IDEIcon("T").image, "time"),
  (IDEIcon("T").image, "timetz"),
  (IDEIcon("T").image, "timestamp"),
  (IDEIcon("T").image, "timestamptz"),
  (IDEIcon("U").image, "uuid"),
  (IDEIcon("V").image, "varchar"),
  (IDEIcon("X").image, "xml"),
]

struct DataModelExample: View {
  @State var data = [
    DataModelAttribute(name: "host", dataType: "string", isRequired: true),
    DataModelAttribute(name: "port", dataType: "integer 16", isRequired: false),
    DataModelAttribute(name: "username", dataType: "string", isRequired: true),
    DataModelAttribute(name: "useSSHTunnel", dataType: "boolean", isRequired: true),
  ]
  
  @State var selection = Set<DataModelAttribute.ID>()
  
  var body: some View {
    CapsuleTable(data, selection: $selection) {
      CapsuleTableColumn("Attribute", value: \.name) { data[$0].name = $1 }
        .withImage {
          IDEIcon(String(($0.dataType.first ?? "?").uppercased()), color: $0.dataType.isEmpty ? .gray : .purple).image
        }
        .withWidth(ideal: 150)
      // CapsuleTableColumn("Type", value: \.dataType) { data[$0].dataType = $1 }
      // CapsuleTableColumn("Type", value: \.dataType) { data[$0].dataType = $1 }
      CapsuleTableColumn("Type", value: \.dataType, completions: dataTypeCompletions) { data[$0].dataType = $1 }
      CapsuleTableColumn("􀅎", value: \.isRequired) { data[$0].isRequired = $1 }
        .withAlignment(.center)
        .withToolTip("Required")
        .withWidth(20)
    }
  }
}

struct CapsuleUIExampleApp_Previews: PreviewProvider {
  static var previews: some View {
    // ScreenshotGroup("../CapsuleUI/Documentation.docc/Resources", relativeTo: #filePath) {
      DataModelExample()
        .frame(width: 480, height: 256)
        .previewDisplayName("CapsuleTable2")
    // }
  }
}
