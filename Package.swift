// swift-tools-version:4.2
// Change swift-tools-version to the Swift version you want to use.
import PackageDescription

let package = Package(
    name: "libMultiMarkdown",
    products: [
        .library(name: "libMultiMarkdown", targets: ["libMultiMarkdown"]),
        .library(name: "MultiMarkdownSPM", targets: ["MultiMarkdownSPM"]),
        .executable(name: "multimarkdown", targets: ["multimarkdown"])
    ],
    dependencies: [],
    targets: [
        .target(name: "libMultiMarkdown", dependencies: []),
        .target(name: "mmd-swift", dependencies: ["libMultiMarkdown"]),
        .target(name: "multimarkdown", dependencies: ["libMultiMarkdown"]),
        .target(name: "MultiMarkdownSPM", dependencies: ["libMultiMarkdown"])
    ]
)
