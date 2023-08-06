// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription


let package = Package(
	name: "HelloWorld",
	products: [
		// Products define the executables and libraries a package produces, making them visible to other packages.
		.executable(
			name: "HelloWorld",
			targets: ["HelloWorld"]),
		
		.library(name: "libobjc", targets: ["libobjc2"]),
		
		.executable(
				name: "NSWindowTest",
				targets: ["NSWindowTest"]),
		
		.library(name: "AppKit", targets: ["AppKit"]),
		
		.library(name: "FoundationGNUStep", targets: ["FoundationGNUStep"]),
		.library(name: "ObjCSwiftInterop",  targets: ["ObjCSwiftInterop"])
		
	],
	targets: [
		// Targets are the basic building blocks of a package, defining a module or a test suite.
		// Targets can depend on other targets in this package and products from dependencies.
		.executableTarget(name: "HelloWorld", dependencies: ["libobjc2", "AppKit", "ObjCSwiftInterop", "FoundationGNUStep"]),
		.executableTarget(name: "NSWindowTest", dependencies: ["libobjc2", "AppKit", "ObjCSwiftInterop", "FoundationGNUStep"]),
		
		.target(name: "ObjCSwiftInterop"),
		
		.systemLibrary(name: "libobjc2"),
		.systemLibrary(name: "AppKit"),
		.systemLibrary(name: "FoundationGNUStep"),
		.testTarget(
			name: "HelloWorldTests",
			dependencies: ["HelloWorld"]),
	]
)
