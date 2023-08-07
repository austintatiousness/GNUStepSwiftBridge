
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

public struct StopVariable {
	public init() {
		
	}
}

public typealias CGRect = ObjCSwiftInterop.CGRect

public func objc_convertToSwift_NSObject(value: id?) -> NSObjectGNUStepSwiftBridge? {
	if var id = value {
		let value = object_getClassName(id)
		if let value = value  {
			let string = String(cString: value)

			if string == "GSTinyString" || string == "GSCBufferString" {
				let rtn = NSString(nsobjptr: &id.pointee)
				let s = rtn.string
				return rtn
			} else {
				print("unknown type \(string)")
			}
		}
	}
	return nil
}

public func objc_convertToSwift_ofType<T>(value: Any?) -> T? {
	print("!!!!!objc_convertToSwift_ofType is \(value)")
	if var id = value {
		print("!!!!!objc_convertToSwift_ofType is \(value)")
		return unsafeBitCast(value, to: T.self)
	}
	return nil
}

public func objc_convertFromSwift_toObjC(value: Any?, typeHint: String? = nil) -> Any? {
	if let value = value as? String {
		return NSString(string: value)
	} else if let value = value as? AnyObject {
		return Unmanaged.passUnretained(value).toOpaque()
	} else if var value = value as? Any {
		return value
	}
	
	return value
}

public func smart_swift_lookupIvar(_nsobjptr: UnsafeMutablePointer<objc_object>?, name: String) -> UnsafeMutableRawPointer? {
	if var ptr = _nsobjptr {
		//let ivar = class_getInstanceVariable(object_getClass(ptr), name)
		//print("looking for \(name)")
		let v: UnsafeMutableRawPointer? = getIvarPointer(ptr, name)

		//print("smart_swift_lookupIvar found \(v) size \(MemoryLayout.size(ofValue: getIvarPointer(ptr, name)))")
		return v
	}
	return nil
}

public func smart_swift_lookupIvarWithType<T>(_nsobjptr: UnsafeMutablePointer<objc_object>?, name: String) -> T? {
	let z = smart_swift_lookupIvar(_nsobjptr: _nsobjptr, name: "___swiftPtr")
	if let SELF = z?.load(as: T.self) {
		return SELF
	}
	return nil
}

public func smart_swift_setIvar(_nsobjptr: UnsafeMutablePointer<objc_object>?, name: String, value: Any) {
	if var ptr = _nsobjptr {
		var value = value
		//let ivar = class_getInstanceVariable(object_getClass(ptr), name)
		_ = object_setInstanceVariable(ptr, name, &value)
	}

}

public func objc_smart_sendMessage<T>(object: NSObjectGNUStepSwiftBridge, selector: String) -> T? {
	return objc_smartobjc_smart_sendMessage_sendMessage(object: object, selector: selector, value1: StopVariable(), value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable())
}

public func objc_smart_sendMessage<T>(object: NSObjectGNUStepSwiftBridge, selector: String,  value1: Any?) -> T? {
	return objc_smart_sendMessage(object: object, selector: selector, value1: value1, value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable())
}

public func objc_smart_sendMessage<T>(object: NSObjectGNUStepSwiftBridge, selector: String,  value1: Any?, value2: Any?, value3: Any?, value4: Any?, value5: Any?, value6: Any?, value7: Any?, value8: Any?, value9: Any?) -> T? {
	var total: UInt = 0
	print("calling \(selector)")
	if value1 is StopVariable {
		total = 0
	} else if value2 is StopVariable {
		total = 1
	} else if value3 is StopVariable {
		total = 2
	} else if value4 is StopVariable {
		total = 3
	} else if value5 is StopVariable {
		total = 4
	} else if value6 is StopVariable {
		total = 5
	} else if value7 is StopVariable {
		total = 6
	} else if value8 is StopVariable {
		total = 7
	} else if value9 is StopVariable {
		total = 8
	}
	
	let objectPtr = object._nsobjptr
	
	var value1Retainer = objc_convertFromSwift_toObjC(value: value1)
	var value2Retainer = objc_convertFromSwift_toObjC(value: value2)
	var value3Retainer = objc_convertFromSwift_toObjC(value: value3)
	var value4Retainer = objc_convertFromSwift_toObjC(value: value4)
	var value5Retainer = objc_convertFromSwift_toObjC(value: value5)
	var value6Retainer = objc_convertFromSwift_toObjC(value: value6)
	print("value1Retainer = \(value1Retainer)")
	var value1Converted = value1
	if let value1 = value1 as? NSObjectGNUStepSwiftBridge {
		value1Converted = value1._nsobjptr
	}
	var value2Converted = value2
	if let value2 = value2 as? NSObjectGNUStepSwiftBridge {
		value2Converted = value2._nsobjptr
	}
	var value3Converted = value3
	if let value3 = value3 as? NSObjectGNUStepSwiftBridge {
		value3Converted = value3._nsobjptr
	}
	var value4Converted = value4
	if let value4 = value4 as? NSObjectGNUStepSwiftBridge {
		value4Converted = value4._nsobjptr
	}
	var value5Converted = value5
	if let value5 = value5 as? NSObjectGNUStepSwiftBridge {
		value5Converted = value5._nsobjptr
	}
	var value6Converted = value6
	if let value6 = value6 as? NSObjectGNUStepSwiftBridge {
		value6Converted = value6._nsobjptr
	}
	
	var returnValue: id? = nil
	if total == 0 {
		
		if T.self == NSObjectGNUStepSwiftBridge.self {
			returnValue  = forSwift_objcSendMessage(&objectPtr!.pointee, sel_registerName(selector))
			if let value =  objc_convertToSwift_NSObject(value: returnValue) as? T {
				return value
			}
		} else {
			//var retrunValue = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
			print("STRET calling a function with 0 argument")
			var retrunValue = forSwift_objcMsgSend_stret(&objectPtr!.pointee, sel_registerName(selector))
			print("STRET calling a function with 0 argument \(retrunValue)")
			if let value: T =  objc_convertToSwift_ofType(value: returnValue) {
				return value
			}
		}
	}
	
	if total == 1 {
		print("calling a function with one argument")
		if T.self == NSObjectGNUStepSwiftBridge.self {
			returnValue  = forSwift_objcSendMessage1(&objectPtr!.pointee, sel_registerName(selector), &value1Converted)
			if let value =  objc_convertToSwift_NSObject(value: returnValue) as? T {
				return value
			}
		} else {
			print("STRET calling a function with one argument \(value1Converted!)")
			//var retrunValue = UnsafeMutablePointer<T>.allocate(capacity: MemoryLayout<T>.size)
			var retrunValue  = forSwift_objcMsgSend_stret1(&objectPtr!.pointee, sel_registerName(selector), &value1Converted!)
			if let value: T =  objc_convertToSwift_ofType(value: returnValue) {
				return value
			}
		}
	}
	
	if returnValue == nil {
		return nil
	}
	
	return nil

}

open class NSObjectGNUStepSwiftBridge {
	public var _nsobjptr: UnsafeMutablePointer<objc_object>? = nil
	public var _nsclassName: String {
		return "NSObject"
	}
	
//	subscript<T>(dynamicMember member: String) -> T? {
//			get {
//				if let x: T = objc_smart_sendMessage(object: self, selector: member, value1: StopVariable(), value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable()) {
//					return x
//				}
//				return nil
//			}
////			set {
////				guard let selfPtr = self._nsobjptr else {return}
////				let p = Unmanaged.passUnretained(newValue).toOpaque()
////				_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("set\(member)"), &p)
////			}
//		}
//	}
	
	public init() {
		
	}
	
	public init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		self._nsobjptr = nsobjptr
	}

	deinit {
		if var ptr = _nsobjptr {
			_ = forSwift_objcSendMessage(&ptr.pointee, sel_registerName("release"))
		}
	}
	
	public func addMethod<T>(selector: String, block: T, types: String) {
		guard var selfPtr = self._nsobjptr else {return}
		guard let CLASS = object_getClass(selfPtr) else {return}
		//print("registering :\(T.self)")
		let imp = imp_implementationWithBlock(unsafeBitCast(block, to: id.self))
		class_addMethod(CLASS, sel_registerName(selector),imp, types)
	}
	
	
}




public class NSObjectClass {
	public var _nsclassName: String
	public var _nsobjptr: Class?
	public init(name: String, superName: String?, create: (Class?) -> ()) {
		self._nsclassName = name
		var cName = name.cString
		print("trying to create \(name)")
		if let superName = superName, var nsClass =  objc_getClass(superName), let cls = object_getClass(nsClass) {
			
			//self._nsobjptr = objc_allocateClassPair(cls, name, 0)
			
			self._nsobjptr = smart_createNewClass(name, superName)
			
			print("Created \(name) subclass of \(superName)")
		} else {
			self._nsobjptr = objc_allocateClassPair(nil, &cName, 0)
			print("Created \(name) subclass of nothing")
		}
		
		if let ptr = self._nsobjptr {
			create(ptr)
			//https://stackoverflow.com/questions/33184826/what-does-class-addivars-alignment-do-in-objective-c
			
			class_addIvar(ptr, "___swiftPtr", MemoryLayout<UInt64>.size, UInt8(MemoryLayout<UInt64>.alignment), "@")
			
		}
		
		
		
		self.register()
		
		print(self._nsobjptr == nil ? "NIL!!!" : "NOT NIL :-)")
		

	}
	
	public init(class: Class, name: String) {
		self._nsclassName = name
		self._nsobjptr = `class`
	}

	public func register() {
		
		if var chars = class_getName(self._nsobjptr!) {
			let name = String(cString: chars)
			print("named: \(name)")
		}
		
		
		
		print("registering class \(self._nsobjptr)")
		objc_registerClassPair(self._nsobjptr!)
		print("registered \(_nsclassName) but got \(objc_getClass(self._nsclassName)) after lookup")
	}

}
///https://stackoverflow.com/questions/11319170/c-as-principal-class-or-a-cocoa-app-without-objc

//@_cdecl("didFinishLaunchingForwarder")
//func didFinishLaunchingForwarder(_ SELF: id,_ selector: SEL,_ argument1: id?) -> (UInt8) {
//	print("HELLO WORLD!")
//	return 0
//}


open class NSApplicationDelegate: NSObjectGNUStepSwiftBridge {
	public override var _nsclassName: String {
		return "NSApplicationDelegateForSwift"
	}
	
	
	
	static var didFinishLaunchingIMP: @convention(block) (UnsafeMutablePointer<objc_object>?,SEL,id?) -> (UInt8) = { first, second, third in
		let SELF: NSApplicationDelegate? = smart_swift_lookupIvarWithType(_nsobjptr: first, name: "___swiftPtr")
		SELF?.applicationDidFinishLaunching(notification: nil)
//		let SELF = z!.load(as: NSApplicationDelegate.self)
//		print(SELF.string)
//		SELF.applicationDidFinishLaunching(notification: nil)
//		

		return 0
	}
	

	open func applicationDidFinishLaunching(notification: Any?) {
		
	}

	static var _objcClass = NSObjectClass(name: "NSApplicationDelegateForSwift", superName: "NSObject", create: { ptr in
		var types = "i@:@"
		let imp = imp_implementationWithBlock(unsafeBitCast(didFinishLaunchingIMP, to: id.self))
		class_addMethod(ptr, sel_registerName("applicationDidFinishLaunching:"),imp, types)
	})
	var string: String = "THIS is THAT"
	public override init() {
		_ = NSApplicationDelegate._objcClass

		super.init()
		
		
		self.string = "THESE ARE THOSE"

		var nclass = objc_getClass("NSApplicationDelegateForSwift")
		
		var initalizedObject = forSwift_objcSendMessage(&nclass!.pointee, sel_getUid("alloc"))
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_getUid("init"))

		self._nsobjptr = initalizedObject

		var cast = Unmanaged.passUnretained(self).toOpaque()
		smart_swift_setIvar(_nsobjptr: self._nsobjptr, name: "___swiftPtr", value: cast)

		//self.addMethod(selector: "applicationDidFinishLaunching:", block: Self.didFinishLaunchingIMP, types: "i@:@")
		
		
	}

	
	

	public func didFinishLaunching(_ OBJ: Any, notification: Any?) -> Void {
		
	}

}

open class UIView: NSView {
	public override var _nsclassName: String {
		return "UIView"
	}
	
	
	
	static var isFlippedIMP: @convention(block) (UnsafeMutablePointer<objc_object>?,SEL) -> (UInt8) = { first, second in
		print("!!!!!!!!!!!!!!!!!!!!!!!!asked if is flipped!")
		return 1
	}
	

	static var _objcClass = NSObjectClass(name: "UIView", superName: "NSScrollView", create: { ptr in
		
	})

	public override init() {
		_ = UIView._objcClass

		super.init()

		var nclass = objc_getClass("UIView")
		
		var types = "c"
		let imp = imp_implementationWithBlock(unsafeBitCast(UIView.isFlippedIMP, to: id.self))
		class_replaceMethod(UIView._objcClass._nsobjptr!, sel_registerName("isFlipped"),imp, types)

		var initalizedObject = forSwift_objcSendMessage(&nclass!.pointee, sel_getUid("alloc"))
		initalizedObject = forSwift_objcSendMessage1NSRect(&initalizedObject!.pointee, sel_getUid("initWithFrame:"), CGRect(x: 0, y: 0, width: 100, height: 100))
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_getUid("retain"))
		self._nsobjptr = initalizedObject

		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_getUid("_rebuildCoordinates"))
		
		//_rebuildCoordinates
		
		var cast = Unmanaged.passUnretained(self).toOpaque()
		smart_swift_setIvar(_nsobjptr: self._nsobjptr, name: "___swiftPtr", value: cast)

	}

	
	

//	public func setFrame(_ rect: ObjCSwiftInterop.CGRect) {
//		guard let selfPtr = self._nsobjptr else {return}
//		_ = forSwift_objcSendMessage1NSRect(&selfPtr.pointee, sel_registerName("setFrame:"), rect)
//	}
	
//	public var subviews: [Any] = []
//	public func addSubview(_ subview: NSView) {
//		subviews.append(subview)
//		guard let selfPtr = self._nsobjptr else {return}
//		if var ptr = subview._nsobjptr{
//			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
//			
//		}
//	}

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
		initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_registerName("retain"))
		self._nsobjptr = initalizedObject

	}
	
	public var string: String {
		get {
			if var chars = forSwift_objcSendMessage_ReturnCString(&self._nsobjptr!.pointee, sel_registerName("cString") ) {
				var v: String = String(cString: chars)
				return v
			}
			return ""
		}
	}
	
	public override init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		super.init()
		var initalizedObject = forSwift_objcSendMessage(&nsobjptr!.pointee, sel_registerName("retain"))
	}
	
//	deinit {
//		if var ptr = self._nsobjptr {
//			_ = forSwift_objcSendMessage(&ptr.pointee, sel_registerName("release"))
//		}
//	}
//	
	
	
}



open class NSView: NSObjectGNUStepSwiftBridge {
	public override var _nsclassName: String {
		return "NSView"
	}
		
	public var subviews: [Any] = []
	public func addSubview(_ subview: NSView) {
		subviews.append(subview)
		guard let selfPtr = self._nsobjptr else {return}
		if var ptr = subview._nsobjptr{
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
			
		}
	}

	public func setBackgroundColor(_ color:  NSColor) {
		guard var colorPtr = color._nsobjptr else {return}
		guard var selfPtr = self._nsobjptr else {return}
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
	}
	
	public var frame: CGRect {
		get {
			print("in frame.get")
			if let x: CGRect = objc_smart_sendMessage(object: self, selector: "frame") {
				return x
			}
			return .init(x: 0, y: 0, width: 0, height: 0)
		}
		set {
			guard let selfPtr = self._nsobjptr else {return}
			let _: Any? = objc_smart_sendMessage(object: self, selector: "setFrame:", value1: newValue)
		}
	}
	
	public func setFrame(_ rect: CGRect) {
		print("set frame: \(rect)")
		guard let selfPtr = self._nsobjptr else {return}
		//let v: Any? = objc_smart_sendMessage(object: self, selector: "setFrame:", value1: rect)
		_ = forSwift_objcSendMessage1NSRect(&selfPtr.pointee, sel_registerName("setFrame:"), rect)
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

		var styleMask: UInt = 1 + 2 + 4 + 8
		var backingStoreType: UInt = 0
		var deferr: Int8 = 0
		var rect = CGRect(x: 200, y: 200, width: 300, height: 300) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))

		allocatedObject = initWithContentRect_styleMask_backing_defer(&allocatedObject!.pointee, sel_registerName("initWithContentRect:styleMask:backing:defer:"), rect, styleMask, backingStoreType, deferr)

		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._nsobjptr = allocatedObject
		self.setTitle(NSString(string: "Untitled Window"))
		
	}


	public func orderFront(sender:  Any?) {
		guard var ptr = self._nsobjptr else {return}
		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("orderFront:"), nil)
	}


	public func setBackgroundColor(_ color:  NSColor) {
		guard var colorPtr = color._nsobjptr else {return}
		guard var selfPtr = self._nsobjptr else {return}
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setBackgroundColor:"), &colorPtr.pointee)
	}

	var title: String {
		set {
			var title = NSString(string: newValue)
			if var ptr = title._nsobjptr, var selfPtr = self._nsobjptr {
				_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setTitle:"), &ptr.pointee)
			}
		}
		
		get {
			if let x: NSString = objc_smart_sendMessage(object: self, selector: "title", value1: StopVariable(), value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable()) {
				return x.string
			}
			return ""
		}
	}
	
	public func setTitle(_ title: NSString) {
		if var ptr = title._nsobjptr, var selfPtr = self._nsobjptr {
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setTitle:"), &ptr.pointee)
		}
	}
	public var subviews: [Any] = []
	public func addSubview(_ subview: NSObjectGNUStepSwiftBridge) {
		subviews.append(subview)
		guard let selfPtr = self._nsobjptr else {return}
		var contentViewPtr =  forSwift_objcSendMessage(&selfPtr.pointee, sel_registerName("contentView"))
		if var ptr = subview._nsobjptr, var contentViewPtr = contentViewPtr {
			_ = forSwift_objcSendMessage1(&contentViewPtr.pointee, sel_registerName("addSubview:"), &ptr.pointee)
		}
	}
	
	var contentView: NSView?
	public func setContentView(_ view: NSView) {
		guard let selfPtr = self._nsobjptr else {return}
		self.contentView = view
		if var ptr = view._nsobjptr {
			var _ =  forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setContentView:"), &ptr.pointee)
			_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("_invalidateCoordinates"), &ptr.pointee)
			_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("_rebuildCoordinates"), &ptr.pointee)
			
			//initalizedObject = forSwift_objcSendMessage(&initalizedObject!.pointee, sel_getUid("_rebuildCoordinates"))
			
			
		}
	}

	public func printWindow() {
		guard let selfPtr = self._nsobjptr else {return}
		_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("print:"), nil)
	}

	public func setFrameOrigin(_ origin: ObjCSwiftInterop.NSPoint) {
		guard var ptr = self._nsobjptr else {return}
		var origin = origin

		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setFrameOrigin:"), &origin)
	}

	
}

public class NSControl: NSView {
	public func setEnabled(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag

		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEnabled:"), &bool)
	}

}

public class NSButton: NSControl {
	
	static var _objcClass = NSObjectClass(name: "NSButtonForSwift", superName: "NSButton", create: { ptr in

	})
	
	public override var _nsclassName: String {
		return "NSButton"
	}

	
	static var ___private_actionIMP: @convention(block) (UnsafeMutablePointer<objc_object>?,SEL,id?) -> (Void) = { first, second, third in
		let SELF: NSButton? = smart_swift_lookupIvarWithType(_nsobjptr: first, name: "___swiftPtr")
		if let SELF = SELF {
			SELF.onAction?(SELF)
		}
	}
	
	lazy var newWindow = NSWindow()
	public lazy var onAction: ((NSButton) -> (Void))? = { first in
		self.newWindow.orderFront(sender: self)
		self.newWindow.setBackgroundColor(NSColor.init(red: 0, green: 0.5, blue: 0.5, alpha: 1.0))
		self.setTitle(NSString(string: "New Title"))
	}
	
	public override init() {
		
		super.init()
		_ = Self._objcClass
		var rect = ObjCSwiftInterop.CGRect(x: 0, y: 0, width: 200, height: 22) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))
		let  nsWindowClass =  objc_getClass("NSButtonForSwift")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))

		allocatedObject = forSwift_objcSendMessage1NSRect(&allocatedObject!.pointee, sel_registerName("initWithFrame:"), rect)
		_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		
		var types = "@"
		let imp = imp_implementationWithBlock(unsafeBitCast(NSButton.___private_actionIMP, to: id.self))
		class_addMethod(object_getClass(&allocatedObject!.pointee), sel_registerName("___private_action:"),imp, types)
		
		
		_ = forSwift_objcSendMessage1ID(&allocatedObject!.pointee, sel_registerName("setTarget:"), allocatedObject!)
		var sel = sel_getUid("___private_action:")
		print("SEL = \(sel!)")
		_ = forSwift_objcSendMessage1SEL(&allocatedObject!.pointee, sel_registerName("setAction:"), sel!)
		
		
		self._nsobjptr = allocatedObject
		
		var cast = Unmanaged.passUnretained(self).toOpaque()
		print("in NSButton about to cast \(cast)")
		smart_swift_setIvar(_nsobjptr: self._nsobjptr, name: "___swiftPtr", value: cast)
		
		
		

		
	}


	public func setTitle(_ text: NSString) {
		if var ptr = text._nsobjptr, var selfPtr = self._nsobjptr {
			_ = forSwift_objcSendMessage1ID(&selfPtr.pointee, sel_registerName("setTitle:"), ptr)
		
		}
	}

	public func setEditable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag

		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEditable:"), &bool)
	}
	
	
 
}

public class NSLabel: NSControl {
	
	public override var _nsclassName: String {
		return "NSTextField"
	}

	public override init() {
		super.init()
		var rect = CGRect(x: 0, y: 0, width: 200, height: 22) //(x: Double(50), y: Double(50), width:  Double(50), height: Double(50))
		let  nsWindowClass =  objc_getClass("NSTextField")
		var allocatedObject = forSwift_objcSendMessage(&nsWindowClass!.pointee, sel_registerName("alloc"))
		

		allocatedObject = forSwift_objcSendMessage1(&allocatedObject!.pointee, sel_registerName("initWithFrame:"), &rect)
		//_ =  forSwift_objcSendMessage(&allocatedObject!.pointee, sel_registerName("retain"))

		self._nsobjptr = allocatedObject
		self.setText(NSString(string: "This is me!"))
		self.setEnabled(true)
		self.setSelectable(true)
		self.setEditable(true)
		
	}


	public func setText(_ text: NSString) {
		if var ptr = text._nsobjptr, var selfPtr = self._nsobjptr {
			_ = forSwift_objcSendMessage1(&selfPtr.pointee, sel_registerName("setStringValue:"), &ptr.pointee)
		
		}
	}

	public func setEditable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag

		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setEditable:"), &bool)
	}

	public func setSelectable(_ flag: ObjCBool) {
		guard var ptr = self._nsobjptr else {return}
		var bool = flag

		_ = forSwift_objcSendMessage1(&ptr.pointee, sel_registerName("setSelectable:"), &bool)
	}

	

}

















