
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKit
import ObjCSwiftInterop

class NSObjectGNUStepSwiftBridge {
	var _ptr: UnsafeMutablePointer<objc_object>? = nil
	var _nsclassName: String {
		return "NSObject"
	}

	deinit {
		print("about to release \(_nsclassName)")
		if var ptr = _ptr {
			print("about to release \(_nsclassName) 1")
			_ = forSwift_objcSendMessage(&ptr.pointee, sel_registerName("release"))
			print("released \(_nsclassName)")
		}
		
	}
	
	func add(selector: String, method: Any?, types: String) {
		guard var selfPtr = self._ptr else {return}
			
	}

}

class NSObjectClass {
	var _nsclassName: String
	var _ptr: Class?
	init(name: String, superName: String?) {
		self._nsclassName = name
		var cName = name.cString
		if let superName = superName, var nsClass =  objc_getClass(superName), let cls = object_getClass(nsClass) {
			//let t: String = nsClass
			self._ptr = objc_allocateClassPair(cls, &cName, 0)
			print("Created \(name) subclass of \(superName)")
		} else {
			self._ptr = objc_allocateClassPair(nil, &cName, 0)
			print("Created \(name) subclass of nothins")
		}
		
		print(self._ptr)
		print(self._ptr == nil ? "NIL!!!" : "NOT NIL :-)")
		

	}

	func register() {
		print("registering class \(self._ptr)")
		objc_registerClassPair(self._ptr!)
		print("registered \(_nsclassName) but got nil after lookup \(objc_getClass(self._nsclassName))")
	}

}

class AppDelegate: NSObjectGNUStepSwiftBridge {
	override var _nsclassName: String {
		return "AppDelegate"
	}

	override init() {
		var objcClass = NSObjectClass(name: "AppDelegate", superName: "NSObject")
		
		super.init()
		
		
		if let ptr = objcClass._ptr {

			var didFinishLaunchingForwarder: @convention(block) (Any?,Any?) -> (Void) = { first, second in
				print("HELLO WORLD asdfasdadfasdfds!")

				App.window.orderFront(sender: nil)
				App.label.setBackgroundColor(NSColor())
				App.window.addSubview(App.label)

				App.window2.orderFront(sender: nil)
				App.window2.setFrameOrigin(NSPoint(x: 300, y: 300))
				App.window2.setTitle(NSString(string: "NOOO"))



			}
			
			var types = "@".cString
			print("about to class_addMethod 2")
			class_addMethod(ptr, sel_registerName("applicationDidFinishLaunching:"),unsafeBitCast(didFinishLaunchingForwarder, to: IMP.self), "@")	
			print("just class_addMethod 3")
		}

		objcClass.register()
		
		print("AppDelegate 1 \(self._nsclassName)")
		var nclass = objc_lookUpClass("AppDelegate")
		print("AppDelegate 2 \(nclass)")
		var initalizedObject = forSwift_objcSendMessage(&nclass!.pointee, sel_registerName("alloc"))
		print("AppDelegate 3")
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("init"))
		print("AppDelegate 4")
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._ptr = initalizedObject

		print("PTR: \(self._ptr)")

		
		
	}

	
	

	func didFinishLaunching(_ OBJ: Any, notification: Any?) -> Void {
		
	}

}

class NSColor: NSObjectGNUStepSwiftBridge {

	override var _nsclassName: String {
		return "NSColor"
	}

	override init() {
		super.init()
		var nsColorClass =  objc_getClass(self._nsclassName)
		var initalizedObject = forSwift_objcSendMessage(&nsColorClass!.pointee, sel_registerName("blueColor"))
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._ptr = initalizedObject

	}
    	
	
}



class NSString: NSObjectGNUStepSwiftBridge {


	override var _nsclassName: String {
		return "NSString"
	}

    	init(string: String) {
		super.init()
		var nsStringClass =  objc_getClass(_nsclassName)
		var cString = string

		var initalizedObject = forSwift_objcSendMessageCString(&nsStringClass!.pointee, sel_registerName("stringWithCString:"), string )
		//initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._ptr = initalizedObject

	}
	
}

class NSView: NSObjectGNUStepSwiftBridge {
	override var _nsclassName: String {
		return "NSView"
	}
	func addSubview(_ subview: NSView) {
		print("about addSubview")
		guard let selfPtr = self._ptr else {return}
		if var ptr = subview._ptr{
			print("about set addSubview 1")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
			print("did set addSubview")
		
		}
	}

	func setBackgroundColor(_ color:  NSColor) {
		print("about to set backgroundcolor")
		guard var colorPtr = color._ptr else {return}
		guard var selfPtr = self._ptr else {return}
		print("about to set setBackgroundColor: 2")
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
		print("did set setBackgroundColor: 2")
	}

	func setEnabled(_ flag: ObjCBool) {
		guard var ptr = self._ptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEnabled:"), &bool)
	}

}

class NSWindow: NSObjectGNUStepSwiftBridge {
	
	override var _nsclassName: String {
		return "NSWindow"
	}

	override init() {
		super.init()
		let  nsWindowClass =  objc_getClass("NSWindow")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))

		var styleMask: UInt64 = 1 + 2 + 4
		var backingStoreType: UInt64 = 0
		var deferr: UInt64 = 0
		var rect = NSRect(x: 200, y: 200, width: 300, height: 300) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))

		allocatedObject = forSwift_objcSendMessage4(&allocatedObject!.pointee, sel_registerName("initWithContentRect:styleMask:backing:defer:"), &rect, &styleMask, &backingStoreType, &deferr)

		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._ptr = allocatedObject
		self.setTitle(NSString(string: "Untitled Window"))
//self.setBackgroundColor(NSColor())
		
	}


	func orderFront(sender:  Any?) {
		guard var ptr = self._ptr else {return}
		print("about to orderFront:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("orderFront:"), nil)
	}


	func setBackgroundColor(_ color:  NSColor) {
		print("about to set backgroundcolor")
		guard var colorPtr = color._ptr else {return}
		guard var selfPtr = self._ptr else {return}
		print("about to set setBackgroundColor: 2")
		//_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
		print("did set setBackgroundColor: 2")
	}

	func setTitle(_ title: NSString) {
		if var ptr = title._ptr, var selfPtr = self._ptr {
			print("about set title")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setTitle:"), &ptr.pointee)
			print("did set title")
		
		}
	}

	func addSubview(_ subview: NSObjectGNUStepSwiftBridge) {
		print("about addSubview")
		guard let selfPtr = self._ptr else {return}
		var contentViewPtr =  forSwift_objcSendMessage(&selfPtr.pointee, sel_registerName("contentView"))
		if var ptr = subview._ptr, var contentViewPtr = contentViewPtr {
			print("about set addSubview 1")
			_ = forSwift_objcSendMessage1(&contentViewPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
			print("did set addSubview")
		
		}
	}

	func printWindow() {
		guard let selfPtr = self._ptr else {return}
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("print:"), nil)
	}

	func setFrameOrigin(_ frame: NSPoint) {
		guard var ptr = self._ptr else {return}
		var frame = frame
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrameOrigin:"), &frame)
	}

	
}

class NSLabel: NSView {
	
	override var _nsclassName: String {
		return "NSTextField"
	}

	override init() {
		super.init()
		print("creating \(_nsclassName)")
		var rect = NSRect(x: 0, y: 0, width: 200, height: 22) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))
		let  nsWindowClass =  objc_getClass("NSTextField")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))
		

		allocatedObject = forSwift_objcSendMessage1(&allocatedObject!.pointee, sel_registerName("initWithFrame:"), &rect)
		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._ptr = allocatedObject
		self.setText(NSString(string: "This is me!"))
		print("created \(_nsclassName)")
		self.setEnabled(true)
		self.setSelectable(true)
		self.setEditable(true)
		
	}


	func setText(_ text: NSString) {
		if var ptr = text._ptr, var selfPtr = self._ptr {
			print("about set text")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setStringValue:"), &ptr.pointee)
			print("did set text")
		
		}
	}

	func setEditable(_ flag: ObjCBool) {
		guard var ptr = self._ptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEditable:"), &bool)
	}

	func setSelectable(_ flag: ObjCBool) {
		guard var ptr = self._ptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setSelectable:"), &bool)
	}

	func setFrame(_ frame: NSRect) {
		guard var ptr = self._ptr else {return}
		var frame = frame
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrame:"), &frame)
	}

}

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
		
		

		//window.setBackgroundColor(NSColor())

//'UnsafeMutablePointer<Int8>
//UnsafeMutablePointer<UnsafePointer<CChar>?>
		//return
		return NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv.pointee)		
	}
}
