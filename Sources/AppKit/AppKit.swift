
// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import FoundationGNUStep
import libobjc2
import AppKitGNUStep
import ObjCSwiftInterop

#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import ObjectiveC
#endif

public typealias CGRect = ObjCSwiftInterop.CGRect

//NSApplication
open class NSApplication: GNUStepNSObjectWrapper {
	public override var _nsclassName: String {
		return "NSApplication"
	}
	public var shared: NSApplication {
		get {
			var sharedApp =  forSwift_objcSendMessage(&self._nsobjptr!.pointee, sel_registerName("sharedApplication"))
			return NSApplication()
		}
	}
}

open class NSApplicationDelegate: GNUStepNSObjectWrapper {
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

	static var _objcClass = GNUStepNSObjectSubclassConstructor(name: "NSApplicationDelegateForSwift", superName: "NSObject", create: { ptr in
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
	

	static var _objcClass = GNUStepNSObjectSubclassConstructor(name: "UIView", superName: "NSScrollView", create: { ptr in
		
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
public class NSColor: GNUStepNSObjectWrapper {

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



public class NSString: GNUStepNSObjectWrapper {


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



open class NSView: GNUStepNSObjectWrapper {
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

public class NSWindow: GNUStepNSObjectWrapper {
	
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
	public func addSubview(_ subview: GNUStepNSObjectWrapper) {
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
	
	static var _objcClass = GNUStepNSObjectSubclassConstructor(name: "NSButtonForSwift", superName: "NSButton", create: { ptr in

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

















