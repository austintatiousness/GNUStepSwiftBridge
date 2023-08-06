
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKitGNUStep
import ObjCSwiftInterop

#if os(macOS)
import ObjectiveC
#endif

public class NSObjectGNUStepSwiftBridge {
	public var _nsobjptr: UnsafeMutablePointer<objc_object>? = nil
	public var _nsclassName: String {
		return "NSObject"
	}

	deinit {
		if var ptr = _nsobjptr {
			_ = forSwift_objcSendMessage(&ptr.pointee, sel_registerName("release"))
		}
	}
	
	public func add(selector: String, method: Any?, types: String) {
		guard var selfPtr = self._nsobjptr else {return}
			
	}

}

public class NSObjectClass {
	public var _nsclassName: String
	public var _nsobjptr: Class?
	public init(name: String, superName: String?) {
		self._nsclassName = name
		var cName = name.cString
		if let superName = superName, var nsClass =  objc_getClass(superName), let cls = object_getClass(nsClass) {
			//let t: String = nsClass
			self._nsobjptr = objc_allocateClassPair(cls, &cName, 0)
			print("Created \(name) subclass of \(superName)")
		} else {
			self._nsobjptr = objc_allocateClassPair(nil, &cName, 0)
			print("Created \(name) subclass of nothins")
		}
		
		print(self._nsobjptr == nil ? "NIL!!!" : "NOT NIL :-)")
		

	}
	
	public init(class: Class, name: String) {
		self._nsclassName = name
		self._nsobjptr = `class`
	}

	public func register() {
		print("registering class \(self._nsobjptr)")
		objc_registerClassPair(self._nsobjptr!)
		print("registered \(_nsclassName) but got \(objc_getClass(self._nsclassName)) after lookup")
	}

}

public class AppDelegate: NSObjectGNUStepSwiftBridge {
	public override var _nsclassName: String {
		return "AppDelegate"
	}

	public override init() {
		var objcClass = NSObjectClass(name: "AppDelegate", superName: "NSObject")
		
		super.init()
		
		
		if let ptr = objcClass._nsobjptr {

			var didFinishLaunchingForwarder: @convention(block) (Any?,Any?) -> (Void) = { first, second in
				print("HELLO WORLD asdfasdadfasdfds!")
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
		self._nsobjptr = initalizedObject

		print("PTR: \(self._nsobjptr)")

		
		
	}

	
	

	public func didFinishLaunching(_ OBJ: Any, notification: Any?) -> Void {
		
	}

}
///https://gnustep.github.io/resources/OpenStepSpec/ApplicationKit/Classes/NSColor.html
public class NSColor: NSObjectGNUStepSwiftBridge {

	public override var _nsclassName: String {
		return "NSColor"
	}

	public override init() {
		super.init()
		var nsColorClass =  objc_getClass(self._nsclassName)
		var initalizedObject = forSwift_objcSendMessage(&nsColorClass!.pointee, sel_registerName("blueColor"))
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._nsobjptr = initalizedObject
	}

	public init(red: Float, green: Float, blue: Float, alpha: Float) {
		super.init()
		var nsColorClass =  objc_getClass(self._nsclassName)
		var red = red
		var green = green
		var blue = blue
		var alpha = alpha
		var initalizedObject = forSwift_objcSendMessage4Floats(&nsColorClass!.pointee, sel_registerName("colorWithCalibratedRed:green:blue:alpha:"), red, green, blue, alpha)
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._nsobjptr = initalizedObject
		//colorWithCalibratedRed
	}
		
	
}



public class NSString: NSObjectGNUStepSwiftBridge {


	public override var _nsclassName: String {
		return "NSString"
	}

	public init(string: String) {
		super.init()
		var nsStringClass =  objc_getClass(_nsclassName)
		var cString = string

		var initalizedObject = forSwift_objcSendMessageCString(&nsStringClass!.pointee, sel_registerName("stringWithCString:"), string )
		//initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._nsobjptr = initalizedObject

	}
	
}

public class NSView: NSObjectGNUStepSwiftBridge {
	public override var _nsclassName: String {
		return "NSView"
	}
	
	public func addSubview(_ subview: NSView) {
		print("about addSubview")
		guard let selfPtr = self._nsobjptr else {return}
		if var ptr = subview._nsobjptr{
			print("about set addSubview 1")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
			print("did set addSubview")
		
		}
	}

	public func setBackgroundColor(_ color:  NSColor) {
		print("about to set backgroundcolor")
		guard var colorPtr = color._nsobjptr else {return}
		guard var selfPtr = self._nsobjptr else {return}
		print("about to set setBackgroundColor: 2")
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
		print("did set setBackgroundColor: 2")
	}


}

public class NSWindow: NSObjectGNUStepSwiftBridge {
	
	public override var _nsclassName: String {
		return "NSWindow"
	}

	public override init() {
		super.init()
		let  nsWindowClass =  objc_getClass("NSWindow")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))

		var styleMask: UInt = 1 + 2 + 4
		var backingStoreType: UInt = 0
		var deferr: Int8 = 0
		var rect = ObjCSwiftInterop.NSRect(x: 200, y: 200, width: 300, height: 300) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))

		allocatedObject = initWithContentRect_styleMask_backing_defer(&allocatedObject!.pointee, sel_registerName("initWithContentRect:styleMask:backing:defer:"), rect, styleMask, backingStoreType, deferr)

		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._nsobjptr = allocatedObject
		self.setTitle(NSString(string: "Untitled Window"))
//self.setBackgroundColor(NSColor())
		
	}


	public func orderFront(sender:  Any?) {
		guard var ptr = self._nsobjptr else {return}
		print("about to orderFront:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("orderFront:"), nil)
	}


	public func setBackgroundColor(_ color:  NSColor) {
		print("about to set backgroundcolor")
		guard var colorPtr = color._nsobjptr else {return}
		guard var selfPtr = self._nsobjptr else {return}
		print("about to set setBackgroundColor: 2")
		//_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
		print("did set setBackgroundColor: 2")
	}

	public func setTitle(_ title: NSString) {
		if var ptr = title._nsobjptr, var selfPtr = self._nsobjptr {
			print("about set title")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setTitle:"), &ptr.pointee)
			print("did set title")
		
		}
	}

	public func addSubview(_ subview: NSObjectGNUStepSwiftBridge) {
		print("about addSubview")
		guard let selfPtr = self._nsobjptr else {return}
		var contentViewPtr =  forSwift_objcSendMessage(&selfPtr.pointee, sel_registerName("contentView"))
		if var ptr = subview._nsobjptr, var contentViewPtr = contentViewPtr {
			print("about set addSubview 1")
			_ = forSwift_objcSendMessage1(&contentViewPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
			print("did set addSubview")
		
		}
	}

	public func printWindow() {
		guard let selfPtr = self._nsobjptr else {return}
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("print:"), nil)
	}

	public func setFrameOrigin(_ origin: ObjCSwiftInterop.NSPoint) {
		guard var ptr = self._nsobjptr else {return}
		var origin = origin
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrameOrigin:"), &origin)
	}

	
}

public class NSControl: NSView {
	public func setEnabled(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEnabled:"), &bool)
	}

}

public class NSButton: NSControl {
	
	public override var _nsclassName: String {
		return "NSButton"
	}

	public override init() {
		super.init()
		var rect = ObjCSwiftInterop.NSRect(x: 0, y: 0, width: 200, height: 22) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))
		let  nsWindowClass =  objc_getClass("NSButton")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))
		

		allocatedObject = forSwift_objcSendMessage1NSRect(&allocatedObject!.pointee, sel_registerName("initWithFrame:"), rect)
		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._nsobjptr = allocatedObject
		//self.setTitle(NSString(string: "Button"))
		//self.setEnabled(true)
		//self.setSelectable(true)
		//self.setEditable(true)
		
	}


	public func setTitle(_ text: NSString) {
		if var ptr = text._nsobjptr, var selfPtr = self._nsobjptr {
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setTitle"), &ptr.pointee)
		
		}
	}

	public func setEditable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEditable:"), &bool)
	}
	
	public func setFrame(_ frame: ObjCSwiftInterop.NSRect) {
		guard var ptr = self._nsobjptr else {return}
		var frame = frame
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrame:"), &frame)
	}

}

public class NSLabel: NSControl {
	
	public override var _nsclassName: String {
		return "NSTextField"
	}

	public override init() {
		super.init()
		print("creating \(_nsclassName)")
		var rect = NSRect(x: 0, y: 0, width: 200, height: 22) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))
		let  nsWindowClass =  objc_getClass("NSTextField")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))
		

		allocatedObject = forSwift_objcSendMessage1(&allocatedObject!.pointee, sel_registerName("initWithFrame:"), &rect)
		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._nsobjptr = allocatedObject
		self.setText(NSString(string: "This is me!"))
		print("created \(_nsclassName)")
		self.setEnabled(true)
		self.setSelectable(true)
		self.setEditable(true)
		
	}


	public func setText(_ text: NSString) {
		if var ptr = text._nsobjptr, var selfPtr = self._nsobjptr {
			print("about set text")
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setStringValue:"), &ptr.pointee)
			print("did set text")
		
		}
	}

	public func setEditable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEditable:"), &bool)
	}

	public func setSelectable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setSelectable:"), &bool)
	}

	public func setFrame(_ frame: ObjCSwiftInterop.NSRect) {
		guard var ptr = self._nsobjptr else {return}
		var frame = frame
		print("about to setEnabled:")
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrame:"), &frame)
	}

}
