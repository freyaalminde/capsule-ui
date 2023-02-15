# Capsule UI (🚧 Work in Progress 🚧)

Capsule UI for AppKit and SwiftUI.

![](/Screenshots/CapsuleList.png?raw=true)


## Installation

```swift
.package(url: "https://github.com/freyaalminde/capsule-ui.git", branch: "main"),
```

```swift
.product(name: "CapsuleUI", package: "capsule-ui"),
```


## Overview

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

![](/Sources/CapsuleUI/Documentation.docc/Resources/CapsuleTable.png?raw=true)

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

