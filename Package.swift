// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "capsule-ui",
  platforms: [
    .macOS(.v12),
  ],
  products: [
    .library(name: "CapsuleUI", targets: ["CapsuleUI"]),
  ],
  dependencies: [
    .package(url: "https://github.com/freyaariel/preview-screenshots.git", branch: "main"),
  ],
  targets: [
    .target(
      name: "CapsuleUI",
      dependencies: [
        .product(name: "PreviewScreenshots", package: "preview-screenshots"),
      ],
      exclude: [
        "CapsuleTableColumnBuilder.swift.gyb",
      ]
    )
  ]
)
