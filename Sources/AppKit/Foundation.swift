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

open class NSArray: GNUStepNSObjectWrapper {
	public override var _nsclassName: String {
		return "NSArray"
	}
	
	///When constructing this from another array, we need to make this a "NSMutableArray" under the hood
	///This makes it easier to pass between objects.
	public init(array: Array<Any>) {
		super.init()
	}
	
	subscript(_ index: Int) -> Any {
		get {
			return 0
		}
		
		set {
			
		}
	}

	public required init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		super.init(nsobjptr: nsobjptr)
	}
}

open class NSMutableArray: NSArray {
	public override var _nsclassName: String {
		return "NSMutableArray"
	}
	
	public override init(array: Array<Any>) {
		super.init(array: array)
	}
	
	public required init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		super.init(nsobjptr: nsobjptr)
	}
}

open class NSTask: GNUStepNSObjectWrapper {
	public override var _nsclassName: String {
		return "NSTask"
	}
	

	public required init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		super.init(nsobjptr: nsobjptr)
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
	
	public override required init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		super.init(nsobjptr: nsobjptr)
	}
	
//	deinit {
//		if var ptr = self._nsobjptr {
//			_ = forSwift_objcSendMessage(&ptr.pointee, sel_registerName("release"))
//		}
//	}
//
		
}

extension String: GNUStepNSObjectConvertable {
	var nsobject: GNUStepNSObjectWrapper {return NSString(string: self)}
	static func from(gnuStepWrapper: GNUStepNSObjectWrapper) -> Any {
		if let gnuStepWrapper = gnuStepWrapper as? NSString {
			return gnuStepWrapper.string
		}
		return ""
	}
}
