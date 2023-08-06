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

#import "../../Headers/objc/objc-visibility.h"

typedef struct _NSRect NSRect;
struct _NSRect {
double x; 
double y; 
double width;
double height; 
};

typedef struct _NSPoint NSPoint;
struct _NSPoint {
double x; 
double y; 
};


typedef unsigned long NSUInteger;

id forSwift_objcSendMessage(id ID, SEL cmd) {
    return objc_msgSend(ID, cmd);
}

id forSwift_objcSendMessage1(id ID, SEL cmd, void const *arg1) {
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
