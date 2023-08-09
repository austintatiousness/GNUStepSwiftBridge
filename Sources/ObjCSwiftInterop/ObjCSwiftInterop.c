#import "include/ObjCSwiftInterop.h"
#import "../../Headers/objc/runtime.h"
#import "../../Headers/objc/objc.h"
#import "../../Headers/objc/message.h"
#import "../../Headers/objc/objc-runtime.h"
#import "../../Headers/objc/runtime.h"
#import "../../Headers/objc/objc-arc.h"
#import "../../Headers/objc/objc-class.h"
#import "../../Headers/objc/capabilities.h"
#import "../../Headers/objc/encoding.h"
#import "../../Headers/objc/objc-auto.h"
#import "../../Headers/objc/hooks.h"
#import "stdio.h"
#import "stdlib.h"
#import "../../Headers/objc/objc-visibility.h"

Class smart_createNewClass(const char* name, const char* superName) {
	Class AppDelClass = objc_allocateClassPair((Class)
										  objc_getClass(superName), name, 0);
	objc_registerClassPair(AppDelClass);
	return AppDelClass;
}

void* getIvarPointer(id object, char const *name) {
	Ivar ivar = class_getInstanceVariable(object_getClass(object), name);
	if (!ivar) return 0;
	return (uint8_t*)(void*)object + ivar_getOffset(ivar);
}

void* forSwift_objcMsgSend_stret(id ID, SEL cmd, int64_t returnSize) {
	printf("forSwift_objcMsgSend_stret\n");
	void* itemArr = malloc(returnSize);
	void* (*sendRectFn)(id receiver, SEL operation);
	sendRectFn = (void(*)(id, SEL))objc_msgSend_stret;
	itemArr = sendRectFn(ID, cmd);
	return itemArr;
	/*
	 This was inspired by this.
	 
	 UIView *view = [[NSView alloc] initWithFrame:NSRectZero];

	 NSRect (*sendRectFn)(id receiver, SEL operation);
	 sendRectFn = (NSRect(*)(id, SEL))objc_msgSend_stret;
	 NSRect frame = sendRectFn(view, @selector(frame));
	 
	 */
}

void* forSwift_objcMsgSend_stret1(id ID, SEL cmd, void const *arg1) {
	objc_msgSend_stret(ID, cmd, arg1);
}

id forSwift_objcSendMessage(id ID, SEL cmd) {
    return objc_msgSend(ID, cmd);
}

void* forSwift_objcSendMessage1ReturnAny(id ID, SEL cmd) {
    return objc_msgSend(ID, cmd);
}

char* forSwift_objcSendMessage_ReturnCString(id ID, SEL cmd) {
	return (char*) objc_msgSend(ID, cmd);
	//return value;
}

id forSwift_objcSendMessage1(id ID, SEL cmd, void const *arg1) {
    return objc_msgSend(ID, cmd,  arg1);
}

id forSwift_objcSendMessage1ID(id ID, SEL cmd, id arg1) {
	return objc_msgSend(ID, cmd,  arg1);
}

id forSwift_objcSendMessage1SEL(id ID, SEL cmd, SEL arg1) {
	return objc_msgSend(ID, cmd,  arg1);
}

id forSwift_objcSendMessageCString(id ID, SEL cmd, const char* bytes) {
    return objc_msgSend(ID, cmd,  bytes);
}

id forSwift_objcSendMessage2(id ID, SEL cmd, void const *arg1, void const *arg2) {
    return objc_msgSend(ID, cmd,  arg1, arg2);
}


id forSwift_objcSendMessage3(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3) {
    return objc_msgSend(ID, cmd,  arg1, arg2, arg3);
}


id forSwift_objcSendMessage4(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3, void const *arg4) {
    return objc_msgSend(ID, cmd,  arg1, arg2, arg3, arg4);
}

id forSwift_objcSendMessage4Floats(id ID, SEL cmd, float arg1, float arg2, float arg3, float arg4) {
	return objc_msgSend(ID, cmd,  arg1, arg2, arg3, arg4);
}

//"initWithContentRect:styleMask:backing:defer:"
id initWithContentRect_styleMask_backing_defer(id ID, SEL cmd, NSRect arg1, NSUInteger arg2, NSUInteger arg3, char arg4) {
	return objc_msgSend(ID, cmd,  arg1, arg2, arg3, arg4);
}

id forSwift_objcSendMessage1NSRect(id ID, SEL cmd, NSRect arg1) {
	return objc_msgSend(ID, cmd,  arg1);
}
