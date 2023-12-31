//
//  SwiftForGNUStep.swift
//  
//
//  Created by Austin Clow on 8/7/23.
//


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

public typealias GNUStepNSObjectPointer = UnsafeMutablePointer<objc_object>

public class GNUStepObjC {
	//the key is the name of the class (e.g "NSView") and the value is the type
	//this is used so we can quickly cast to these objects from the ObjC Runtime
	public static var registeredClasses: [String : GNUStepNSObjectWrapper.Type] = [:]
	public static func registerClass(name: String, type: GNUStepNSObjectWrapper.Type) {
		GNUStepObjC.registeredClasses[name] = type
	}
}

public struct StopVariable {
	public init() {
		
	}
}

public struct NilVariable {
	static var single = NilVariable()
	public init() {
		
	}
}

//This function takes the 'id' pointer, attempts to figure out what class it belongs to
//then creates a new Swif object that wraps it.
//There are a lot of questions to be solved here, like .. do we retain it again?
public func objc_convertToSwift_NSObject(value: id?) -> GNUStepNSObjectWrapper? {
	if var id = value {
		let value = object_getClassName(id)
		if let value = value  {
			let string = String(cString: value)

			if string == "GSTinyString" || string == "GSCBufferString" || string == "NSString" {
				let rtn = NSString(nsobjptr: &id.pointee)
				return rtn
			} else if let type = GNUStepObjC.registeredClasses[string].self {
				return type.init(nsobjptr: &id.pointee)
			} else {
				print("unknown type \(string)")
			}
		}
	}
	return nil
}

public func objc_convertToSwift_ofType<T>(value: Any) -> T? {
	
	let bytesPointer = UnsafeMutableRawPointer.allocate(byteCount: MemoryLayout<T>.size, alignment: MemoryLayout<T>.alignment)
	
	if let v = value as? UnsafeMutablePointer<objc_object> {
		let rt: T? = unsafeBitCast(v.pointee, to: T.self)
		if var rt = rt {
			return rt
		}
		return nil
	}
	let rt: T? = unsafeBitCast(value, to: T.self)
	if var rt = rt {
		return rt
	}
	return nil
}

public func objc_convertFromSwift_toObjC(value: Any?, typeHint: String? = nil) -> Any {
	if let value = value as? String {
		return NSString(string: value)
	} else if var value = value {
		return value
	}
	
	return NilVariable.single
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
	let z = smart_swift_lookupIvar(_nsobjptr: _nsobjptr, name: name)
	if let SELF = z?.load(as: T.self) {
		return SELF
	}
	return nil
}

public func smart_swift_setIvar(_nsobjptr: UnsafeMutablePointer<objc_object>?, name: String, value: Any) {
	if var ptr = _nsobjptr {
		var value = value
		_ = object_setInstanceVariable(ptr, name, &value)
	}
}

public func objc_smart_sendMessage<T>(object: GNUStepNSObjectWrapper, selector: String) -> T? {
	return objc_smart_sendMessage(object: object, selector: selector, value1: StopVariable(), value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable())
}

public func objc_smart_sendMessage<T>(object: GNUStepNSObjectWrapper, selector: String,  value1: Any?) -> T? {
	return objc_smart_sendMessage(object: object, selector: selector, value1: value1, value2: StopVariable(), value3: StopVariable(), value4: StopVariable(), value5: StopVariable(), value6: StopVariable(), value7: StopVariable(), value8: StopVariable(), value9: StopVariable())
}

public func objc_smart_getIMP<T>(object: GNUStepNSObjectWrapper, selector: String) -> T? {
	let c = object_getClass(&object._nsobjptr!.pointee)
	let v = class_getMethodImplementation(c, sel_getUid(selector))
	let rt: T? = unsafeBitCast(v, to: T.self)
	return rt
}

public func objc_smart_getIMP<T>(id: GNUStepNSObjectPointer, selector: String) -> T? {
	var id = id
	let c = object_getClass(id)
	let v = class_getMethodImplementation(c, sel_getUid(selector))
	let rt: T? = unsafeBitCast(v, to: T.self)
	return rt
}

public func objc_smart_getClassIMP<T>(class: Class, selector: String) -> T? {
	let v = method_getImplementation(class_getClassMethod(`class`, sel_getUid(selector)))
	let rt: T? = unsafeBitCast(v, to: T.self)
	return rt
}

///This cannot work because ReturnType is not guaranteed to be a C type or a Pointer
//public func objc_call_IMP1<ReturnType: Any>(object: GNUStepNSObjectWrapper, selector: String) -> ReturnType {
//	let rt: (@convention(c) (id, SEL) -> (ReturnType))? = objc_smart_getIMP(object: object, selector: selector)
//	return rt!(&object._nsobjptr!.pointee, sel_getUid(selector))!
//}

public func objc_smart_getIMP_stret<T>(object: GNUStepNSObjectWrapper, selector: String) -> T? {
	let c = object_getClass(&object._nsobjptr!.pointee)
	let v = class_getMethodImplementation_stret(c, sel_getUid(selector))
	let rt: T? = unsafeBitCast(v, to: T.self)
	return rt
}

public func objc_smart_sendMessage<T>(object: GNUStepNSObjectWrapper, selector: String,  value1: Any?, value2: Any?, value3: Any?, value4: Any?, value5: Any?, value6: Any?, value7: Any?, value8: Any?, value9: Any?) -> T? {
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
	
	var value1Retainer: Any = objc_convertFromSwift_toObjC(value: value1)
	var value1Ptr: UnsafeMutablePointer<objc_object>? = nil
	var value2Retainer: Any = objc_convertFromSwift_toObjC(value: value2)
	var value3Retainer: Any = objc_convertFromSwift_toObjC(value: value3)
	var value4Retainer: Any = objc_convertFromSwift_toObjC(value: value4)
	var value5Retainer: Any = objc_convertFromSwift_toObjC(value: value5)
	var value6Retainer: Any = objc_convertFromSwift_toObjC(value: value6)
	var value1Converted = value1
	if let value1 = value1 as? GNUStepNSObjectWrapper {
		value1Ptr = value1._nsobjptr
	}
	var value2Converted = value2
	if let value2 = value2 as? GNUStepNSObjectWrapper {
		value2Converted = value2._nsobjptr
	}
	var value3Converted = value3
	if let value3 = value3 as? GNUStepNSObjectWrapper {
		value3Converted = value3._nsobjptr
	}
	var value4Converted = value4
	if let value4 = value4 as? GNUStepNSObjectWrapper {
		value4Converted = value4._nsobjptr
	}
	var value5Converted = value5
	if let value5 = value5 as? GNUStepNSObjectWrapper {
		value5Converted = value5._nsobjptr
	}
	var value6Converted = value6
	if let value6 = value6 as? GNUStepNSObjectWrapper {
		value6Converted = value6._nsobjptr
	}
	
	var returnValue: id? = nil
	if total == 0 {
		if T.self == GNUStepNSObjectWrapper.self {
			
			
			returnValue  = forSwift_objcSendMessage(&objectPtr!.pointee, sel_registerName(selector))
			if let value =  objc_convertToSwift_NSObject(value: returnValue) as? T {
				return value
			}
		} else {
			var returnValue  = forSwift_objcMsgSend_stret(&objectPtr!.pointee, sel_registerName(selector), Int64(MemoryLayout<T>.size))

			if let value: T =  objc_convertToSwift_ofType(value: returnValue!) {
				print("STRET for sure worked.")
				return value
			} else {
				print("STRET coumd not be converted.")
			}
		}
	}
	
	if total == 1 {
		print("calling a function with one argument")
		if T.self == GNUStepNSObjectWrapper.self {
			if var value1Ptr = value1Ptr {
				returnValue  = forSwift_objcSendMessage1(&objectPtr!.pointee, sel_registerName(selector), &value1Ptr.pointee)
			} else {
				returnValue  = forSwift_objcSendMessage1(&objectPtr!.pointee, sel_registerName(selector), &value1Converted)
			}
			
			if let value =  objc_convertToSwift_NSObject(value: returnValue) as? T {
				return value
			}
		} else {
			print("STRET calling a function with one argument \(value1Converted!)")
			
			if var value1Ptr = value1Ptr {
				var returnValue  = forSwift_objcMsgSend_stret1(&objectPtr!.pointee, sel_registerName(selector), &value1Ptr.pointee)
				
				if let value: T =  objc_convertToSwift_ofType(value: returnValue) {
					return value
				}
				
			} else {
				var returnValue  = forSwift_objcMsgSend_stret1(&objectPtr!.pointee, sel_registerName(selector), &value1Converted)
				
				if let value: T =  objc_convertToSwift_ofType(value: returnValue) {
					return value
				}
				
			}
			
			//var retrunValue  = forSwift_objcMsgSend_stret1(&objectPtr!.pointee, sel_registerName(selector), &value1Converted!)
			//if let value: T =  objc_convertToSwift_ofType(value: returnValue) {
			//	return value
			//}
		}
	}
	
	if returnValue == nil {
		return nil
	}
	
	return nil

}

func convertGetterToSetter(_ string: String) -> String {
	if string.count > 0 {
		let first = "\(string.first!)".uppercased()
		return "set\(first)\(string.dropFirst()):"
	} else {
		return string
	}
}
	
protocol GNUStepNSObjectConvertable {
	var nsobject: GNUStepNSObjectWrapper {get}
	static func from(gnuStepWrapper: GNUStepNSObjectWrapper) -> Any
}


///This is used to wrap
@dynamicMemberLookup
open class GNUStepNSObjectWrapper {
	public var _nsobjptr: GNUStepNSObjectPointer? = nil
	public var _nsclassName: String {
		return "NSObject"
	}
	
	
	public subscript<T>(dynamicMember member: String) -> T? {
		
		get {
			if T.self == GNUStepNSObjectWrapper.self {
				var imp:  (@convention(c) (id, SEL) -> (id))? = objc_smart_getIMP(object: self, selector: member)
				if let rtn = imp?(&self._nsobjptr!.pointee, sel_getUid(member)) {
					if let rtn = objc_convertToSwift_NSObject(value: rtn) as? T {
						return rtn
					}
				}
			} else if let Type = T.self as? GNUStepNSObjectConvertable.Type {
				var imp:  (@convention(c) (id, SEL) -> (id))? = objc_smart_getIMP(object: self, selector: member)
				if let rtn = imp?(&self._nsobjptr!.pointee, sel_getUid(member)) {
					if let rtn = objc_convertToSwift_NSObject(value: rtn) {
						return Type.from(gnuStepWrapper: rtn) as? T
					}
				}
			} else if T.self == Int.self {
				var imp:  (@convention(c) (id, SEL) -> (Int))? = objc_smart_getIMP(object: self, selector: member)
				if let rtn = imp?(&self._nsobjptr!.pointee, sel_getUid(member)) {
					return rtn as? T
				}
			}
			return nil
		}
		
		set {
			guard var selfPtr = self._nsobjptr else {return}
			if let ns = newValue as? GNUStepNSObjectWrapper {
				guard var stringPTR = ns._nsobjptr else {return}
				var imp:  (@convention(c) (id, SEL, id) -> (Void))? = objc_smart_getIMP(object: self, selector: convertGetterToSetter(member))
				let rtn = imp?(&selfPtr.pointee, sel_getUid(convertGetterToSetter(member)), &stringPTR.pointee)
			} else if let nv = newValue as? GNUStepNSObjectConvertable {
				let ns = nv.nsobject
				guard var stringPTR = ns._nsobjptr else {return}
				var imp:  (@convention(c) (id, SEL, id) -> (Void))? = objc_smart_getIMP(object: self, selector: convertGetterToSetter(member))
				let rtn = imp?(&selfPtr.pointee, sel_getUid(convertGetterToSetter(member)), &stringPTR.pointee)
			} else if let ns = newValue as? Int {
				var imp:  (@convention(c) (id, SEL, Int) -> (Void))? = objc_smart_getIMP(object: self, selector: convertGetterToSetter(member))
				let rtn = imp?(&selfPtr.pointee, sel_getUid(convertGetterToSetter(member)), ns)
			} else if let ns = newValue as? CGRect {
				var imp:  (@convention(c) (id, SEL, CGRect) -> (Void))? = objc_smart_getIMP(object: self, selector: convertGetterToSetter(member))
				let rtn = imp?(&selfPtr.pointee, sel_getUid(convertGetterToSetter(member)), ns)
			}
		}
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
	
	public required init(nsobjptr: UnsafeMutablePointer<objc_object>?) {
		self._nsobjptr = nsobjptr
		var initalizedObject = forSwift_objcSendMessage(&nsobjptr!.pointee, sel_registerName("retain"))
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
	
	func retain() {
		var imp:  (@convention(c) (id, SEL) -> (Void))? = objc_smart_getIMP(object: self, selector: "retain")
		let rtn = imp?(&self._nsobjptr!.pointee, sel_getUid("retain"))
	}
		
	func release() {
		var imp:  (@convention(c) (id, SEL) -> (Void))? = objc_smart_getIMP(object: self, selector: "release")
		let rtn = imp?(&self._nsobjptr!.pointee, sel_getUid("release"))
	}
	
	
}



///This class is used to register a new Subclass with the GNUStep Objective-C runtime.
///You do not use this class to use pre-existing classes from libraries that you import.
public class GNUStepNSObjectSubclassConstructor {
	public var _nsclassName: String
	public var _nsobjptr: Class?
	public init(name: String, superName: String?, create: (Class?) -> ()) {
		self._nsclassName = name
		var cName = name.cString
		if let superName = superName, var nsClass =  objc_getClass(superName), let cls = object_getClass(nsClass) {
			self._nsobjptr = smart_createNewClass(name, superName)
		} else {
			self._nsobjptr = objc_allocateClassPair(nil, &cName, 0)
		}
		
		if let ptr = self._nsobjptr {
			create(ptr)
			class_addIvar(ptr, "___swiftPtr", MemoryLayout<UInt64>.size, UInt8(MemoryLayout<UInt64>.alignment), "@")
		}
		self.register()
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
		objc_registerClassPair(self._nsobjptr!)
		//print("registered \(_nsclassName) but got \(objc_getClass(self._nsclassName)) after lookup")
	}

}
///https://stackoverflow.com/questions/11319170/c-as-principal-class-or-a-cocoa-app-without-objc

//@_cdecl("didFinishLaunchingForwarder")
//func didFinishLaunchingForwarder(_ SELF: id,_ selector: SEL,_ argument1: id?) -> (UInt8) {
//	print("HELLO WORLD!")
//	return 0
//}
