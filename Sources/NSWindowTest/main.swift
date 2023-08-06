
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKitGNUStep
import ObjCSwiftInterop
import AppKit

@main
struct App {
	static var window = NSWindow()
	static var window2 = NSWindow()

	static var label = NSLabel()
	static func main() {
		print("Hello World Times Two")

		//var poolClass = objc_getClass("NSAutoreleasePool")
		//var poolClassAllocated =  forSwift_objcSendMessage(&objc_getClass("NSAutoreleasePool")!.pointee, sel_registerName("alloc"))
		//_ =  forSwift_objcSendMessage(&poolClassAllocated!.pointee, sel_registerName("init"))

		let napClass =  objc_getClass("NSApplication")
		var sharedApp =  forSwift_objcSendMessage(&napClass!.pointee, sel_registerName("sharedApplication"))
		
		App.window.orderFront(sender: nil)
		App.label.setBackgroundColor(NSColor())
		App.window.addSubview(App.label)

		App.window2.orderFront(sender: nil)
		App.window2.setFrameOrigin(NSPoint(x: 300, y: 300))
		App.window2.setTitle(NSString(string: "Window 2"))
		
		//App.window2.printWindow()
		

		//window.setBackgroundColor(NSColor())

//'UnsafeMutablePointer<Int8>
//UnsafeMutablePointer<UnsafePointer<CChar>?>
		//return
		return NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv.pointee)		
	}
}
