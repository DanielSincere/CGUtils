// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "CGUtils",
  platforms: [
    .macOS(.v12),
    .iOS(.v15)
  ],
  dependencies: [],
  targets: [
    .target(name: "CGUtils", dependencies: [])
  ]
)
