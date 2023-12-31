#import "../../../Headers/objc/runtime.h"
#import "../../../Headers/objc/objc.h"
#import "../../../Headers/objc/message.h"
#import "../../../Headers/objc/objc-runtime.h"
#import "../../../Headers/objc/runtime.h"
#import "../../../Headers/objc/objc-arc.h"
#import "../../../Headers/objc/objc-class.h"
#import "../../../Headers/objc/capabilities.h"
#import "../../../Headers/objc/encoding.h"
#import "../../../Headers/objc/objc-auto.h"
#import "../../../Headers/objc/hooks.h"

#import "../../../Headers/objc/objc-visibility.h"

typedef uintptr_t NSUInteger;

typedef struct _NSRect NSRect;
struct _NSRect {
double x;
double y;
double width;
double height;
};

typedef NSRect CGRect;

typedef struct _NSPoint NSPoint;
struct _NSPoint {
double x;
double y;
};

typedef NSPoint CGPoint;

Class smart_createNewClass(const char* name, const char* superName);

void* getIvarPointer(id object, char const *name);

char* forSwift_objcSendMessage_ReturnCString(id ID, SEL cmd);


id forSwift_objcSendMessage(id ID, SEL cmd);
id forSwift_objcSendMessage1(id ID, SEL cmd, void const *arg1);

void* forSwift_objcSendMessage1ReturnAny(id ID, SEL cmd);

id forSwift_objcSendMessage1ID(id ID, SEL cmd, id arg1);
id forSwift_objcSendMessage1SEL(id ID, SEL cmd, SEL arg1);

id forSwift_objcSendMessageCString(id ID, SEL cmd, const char* bytes);
id forSwift_objcSendMessage2(id ID, SEL cmd, void const *arg1, void const *arg2);
id forSwift_objcSendMessage3(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3);
id forSwift_objcSendMessage4(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3, void const *arg4);


id forSwift_objcSendMessage4Floats(id ID, SEL cmd, float arg1, float arg2, float arg3, float arg4);
id initWithContentRect_styleMask_backing_defer(id ID, SEL cmd, NSRect arg1, NSUInteger arg2, NSUInteger arg3, char arg4);
id forSwift_objcSendMessage1NSRect(id ID, SEL cmd, NSRect arg1);

void* forSwift_objcMsgSend_stret(id ID, SEL cmd, int64_t returnSize);
void* forSwift_objcMsgSend_stret1(id ID, SEL cmd, void const *arg1);
