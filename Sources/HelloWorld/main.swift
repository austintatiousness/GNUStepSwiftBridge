
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKitGNUStep
import ObjCSwiftInterop
import AppKit

class AppDelegate: NSApplicationDelegate {
	lazy var window = NSWindow()
	lazy var button = NSButton()
	lazy var view = UIView()
	override func applicationDidFinishLaunching(notification: Any?) {
		window.orderFront(sender: self)
		
		button.setFrame(.init(x: 10, y: 0, width: 200, height: 22))
		view.setBackgroundColor(.init(red: 1.0, green: 0.0, blue: 1.0, alpha: 1.0))
		window.setContentView(view)
		view.addSubview(button)
	}
}

@main
struct App {
	static var window = NSWindow()
	static var delegate = AppDelegate()
	static var window2 = NSWindow()

	static var label = NSLabel()
	static func main() {
		print("Hello World Times Two")

		//var poolClass = objc_getClass("NSAutoreleasePool")
		//var poolClassAllocated =  forSwift_objcSendMessage(&objc_getClass("NSAutoreleasePool")!.pointee, sel_registerName("alloc"))
		//_ =  forSwift_objcSendMessage(&poolClassAllocated!.pointee, sel_registerName("init"))

		
		//https://stackoverflow.com/questions/24662864/swift-how-to-use-sizeof
		
		
		
		let napClass =  objc_getClass("NSApplication")
		var sharedApp =  forSwift_objcSendMessage(&napClass!.pointee, sel_registerName("sharedApplication"))
		print("Just created NSApplication")
		

		
		let v = forSwift_objcSendMessage1ID(&sharedApp!.pointee, sel_getUid("setDelegate:"), delegate._nsobjptr!)
		print("made it!")

		
		

		//window.setBackgroundColor(NSColor())

//'UnsafeMutablePointer<Int8>
//UnsafeMutablePointer<UnsafePointer<CChar>?>
		//return
		return NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv.pointee)		
	}
}
