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
    .package(url: "https://github.com/freyaariel/previews-capture.git", branch: "main"),
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
