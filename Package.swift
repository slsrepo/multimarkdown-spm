// swift-tools-version:5.0
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
            path: "swift/libMultiMarkdown",
            cSettings: [
                .define("DISABLE_OBJECT_POOL", to: "1"),
            ],
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-no_application_extension"])
            ]
        ),
        .target(
            name: "mmd-swift",
            dependencies: ["libMultiMarkdown"],
            path: "swift/mmd-swift"
        ),
        .target(
            name: "multimarkdown",
            dependencies: ["libMultiMarkdown"],
            path: "swift/multimarkdown",
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-no_application_extension"])
            ]
        ),
        .target(
            name: "MultiMarkdownSPM",
            dependencies: ["libMultiMarkdown"],
            path: "swift/MultiMarkdownSPM",
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-no_application_extension"])
            ]
        )
    ]
)
