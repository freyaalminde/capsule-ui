# Capsule UI

Capsule UI for AppKit and SwiftUI.

![](https://github.com/freyaariel/capsule-ui/blob/main/Screenshots/CapsuleList.png?raw=true)


## Installation

```swift
.package(url: "https://github.com/freyaariel/capsule-ui.git", branch: "main")
```

```swift
import CapsuleUI
```


## Usage

```swift
CapsuleList {
  Capsule("Form Capsule") {
    Form {
      // …
    }
  }
  Capsule("Table Capsule") {
    CapsuleTable(data) {
      // …
    }
  }
}
```


### Table Usage

![](https://github.com/freyaariel/capsule-ui/blob/main/Sources/CapsuleUI/Documentation.docc/Resources/CapsuleTable.png?raw=true)

```swift
CapsuleTable(data, selection: $selection) {
  CapsuleTableColumn("Name", value: \.name)
  CapsuleTableColumn("Email Address", value: \.emailAddress)
}

```


#### Images

```swift
CapsuleTable(data, selection: $selection) {
  CapsuleTableColumn("Name", value: \.name)
    .withImage { row in
      NSImage(systemSymbolName: "person", accessibilityDescription: nil)
    }

  CapsuleTableColumn("Email Address", value: \.emailAddress)
}
```

