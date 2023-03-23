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
  targets: [
    .target(
      name: "CapsuleUI",
      exclude: [
        "CapsuleTableColumnBuilder.swift.gyb",
      ]
    )
  ]
)
