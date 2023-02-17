// swift-tools-version: 5.5
import PackageDescription

let package = Package(
  name: "capsule-ui",
  defaultLocalization: "en",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "CapsuleUI", targets: ["CapsuleUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/freyaalminde/previews-capture.git", branch: "refactor"),
  ],
  targets: [
    .target(
      name: "CapsuleUI",
      dependencies: [
        .product(name: "PreviewsCapture", package: "previews-capture"),
      ],
      exclude: [
        "CapsuleTableColumnBuilder.swift.gyb",
      ]
    )
  ]
)
