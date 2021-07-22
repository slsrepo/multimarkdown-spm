// swift-tools-version:4.2
// Change swift-tools-version to the Swift version you want to use.
import PackageDescription

let package = Package(
    name: "multimarkdown-spm",
    products: [
        .library(name: "libMultiMarkdown", targets: ["libMultiMarkdown"]),
        .library(name: "MultiMarkdownSPM", targets: ["MultiMarkdownSPM"]),
        .executable(name: "multimarkdown", targets: ["multimarkdown"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "libMultiMarkdown",
            dependencies: [],
            path: "swift/libMultiMarkdown"
        ),
        .target(
            name: "mmd-swift",
            dependencies: ["libMultiMarkdown"],
            path: "swift/mmd-swift",
            cSettings: [
                .define("DISABLE_OBJECT_POOL", to: "1"),
            ]
        ),
        .target(
            name: "multimarkdown",
            dependencies: ["libMultiMarkdown"],
            path: "swift/multimarkdown"
        ),
        .target(
            name: "MultiMarkdownSPM",
            dependencies: ["libMultiMarkdown"],
            path: "swift/MultiMarkdownSPM",
            cSettings: [
                .define("DISABLE_OBJECT_POOL", to: "1"),
            ]
        )
    ]
)
